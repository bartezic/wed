class Partner < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug, use: :slugged

  translates :name, :description, :info, :encrypted_password
  
  devise :database_authenticatable, :timeoutable

  has_attached_file :avatar,
    :styles => { 
      :thumb_100 => ['100x100#', :jpg],
      :thumb_250 => ['250x250#', :jpg]
    },
    :convert_options => { 
      :thumb_100 => "-interlace Plane",
      :thumb_250 => "-interlace Plane"
    },
    :default_url => "/assets/ph/:attachment_:style.gif", 
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"

  # before_save :upload_asset_from_remote_url
  # before_save :change_file_name

  # def upload_asset_from_remote_url
  #   self.asset = open(asset_remote_url) if asset_remote_url.present?
  #   # self.cover.clear if remove_cover == '1'
  # rescue OpenURI::HTTPError
  # end

  # def change_file_name
  #   extension = File.extname(asset_remote_url.present? ? asset_remote_url : asset_file_name).gsub(/^\.+/, '')
  #   name = title.to_slug.normalize(transliterations: :ukrainian).to_s
  #   asset.instance_write(:file_name, "#{name}.#{extension}")
  # end
end
