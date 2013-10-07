class Photo < ActiveRecord::Base
  belongs_to :gallery

  has_attached_file :asset,
    :styles => { 
      :thumb_150 => ['150x110#', :jpg]
    },
    :convert_options => { 
      :thumb_150 => "-interlace Plane"
    },
    :default_url => "/assets/ph/:attachment_:style.gif", 
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"

  before_save :upload_asset_from_remote_url
  before_save :change_file_name

  def upload_asset_from_remote_url
    self.asset = open(asset_remote_url) if asset_remote_url.present?
    # self.cover.clear if remove_cover == '1'
  rescue OpenURI::HTTPError
  end

  def change_file_name
    gal = self.gallery
    part = gal.partner
    p gal.inspect
    p part.inspect
    extension = File.extname(asset_remote_url.present? ? asset_remote_url : asset_file_name).gsub(/^\.+/, '')
    asset.instance_write(:file_name, "#{gal ? gal.slug : 'portfolio'}.#{extension}")
  end
end