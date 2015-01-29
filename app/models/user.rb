class User < ActiveRecord::Base
  belongs_to :rolable, polymorphic: true
  
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  has_attached_file :avatar,
    :styles => { 
      :thumb_100 => ['100x100#', :jpg],
      :thumb_220 => ['220x220#', :jpg]
    },
    :convert_options => { 
      :thumb_100 => "-interlace Plane -quality 100",
      :thumb_220 => "-interlace Plane -quality 100"
    },
    :default_url => "ph/:attachment_:style.gif", 
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  before_validation :upload_avatar_from_remote_url
  # before_save :change_file_name


  TEMP_EMAIL_PREFIX = 'wedcitypro'
  TEMP_EMAIL_REGEX = /\Awedcitypro/

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def self.find_for_oauth(auth, signed_in_resource = nil)
    puts auth.inspect, auth.info.urls
    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        tmp_pswd = Devise.friendly_token[0,10]
        partner = Partner.new(
          name: auth.info.name,
          user_attributes: {
            email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
            password: tmp_pswd,
            temp_password: tmp_pswd,
            avatar_remote_url: get_avatar_url(auth)
          }
        )
        user = partner.user
        partner.save!
        user.save!
        if email_is_verified
          user.skip_confirmation_notification!
          user.skip_confirmation!
        end
      end
    end

    if (partner = user.rolable) && user.is_partner?
      partner.socials = (partner.socials || {}).merge({
        auth.provider => auth.info.urls.send(auth.provider.capitalize.to_sym)
      })
      partner.save!
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def self.get_avatar_url(auth)
    if auth.provider == 'vkontakte' || auth.provider == 'google_oauth2'
      auth.info.image 
    elsif auth.provider == 'facebook' && auth.info.image
      url = "#{auth.info.image}?redirect=0&height=200&type=normal&width=200"
      JSON.load(open(url))['data']['url']
    end
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end




  def upload_avatar_from_remote_url
    self.avatar = open(avatar_remote_url) if avatar_remote_url.present?
    # self.cover.clear if remove_cover == '1'
  rescue
  end

  # def change_file_name
  #   extension = File.extname(asset_remote_url.present? ? asset_remote_url : asset_file_name).gsub(/^\.+/, '')
  #   name = title.to_slug.normalize(transliterations: :ukrainian).to_s
  #   asset.instance_write(:file_name, "#{name}.#{extension}")
  # end

  def is_partner?
    rolable_type == 'Partner'
  end

  def is_manager?
    rolable_type == 'Manager'
  end
end
