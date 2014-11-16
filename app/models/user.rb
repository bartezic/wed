class User < ActiveRecord::Base
  belongs_to :rolable, polymorphic: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  has_attached_file :avatar,
    :styles => { 
      :thumb_100 => ['100x100#', :jpg],
      :thumb_220 => ['220x220#', :jpg]
    },
    :convert_options => { 
      :thumb_100 => "-interlace Plane",
      :thumb_220 => "-interlace Plane"
    },
    :default_url => "ph/:attachment_:style.gif", 
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  before_validation :upload_avatar_from_remote_url
  # before_save :change_file_name

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
