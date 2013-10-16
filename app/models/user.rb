class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to :rolable, polymorphic: true

  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_attached_file :avatar,
    :styles => { 
      :thumb_100 => ['100x100#', :jpg],
      :thumb_220 => ['220x220#', :jpg]
    },
    :convert_options => { 
      :thumb_100 => "-interlace Plane",
      :thumb_220 => "-interlace Plane"
    },
    :default_url => "/assets/ph/:attachment_:style.gif", 
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"


  before_save :upload_avatar_from_remote_url
  # before_save :change_file_name

  def upload_avatar_from_remote_url
    self.avatar = open(avatar_remote_url) if avatar_remote_url.present?
    # self.cover.clear if remove_cover == '1'
  rescue OpenURI::HTTPError
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
