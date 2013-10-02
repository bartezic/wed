class Video < ActiveRecord::Base
  belongs_to :partner
  translates :name, :description

  has_attached_file :asset, 
    :styles => {
      :medium_mp4 => { :geometry => "640x480", :format => 'mp4' },
      :medium_webm => { :geometry => "640x480", :format => 'webm' },
      :thumb => { :geometry => "100x100#", :format => 'jpg', :time => 10 }
    }, 
    :default_url => "/assets/ph/:attachment_:style.gif", 
    :path => ":rails_root/public/system/videos/:attachment/:id/:style/:filename",
    :url => "/system/videos/:attachment/:id/:style/:filename",
    :processors => [:ffmpeg]

  before_save :upload_asset_from_remote_url
  before_save :change_file_name

  def upload_asset_from_remote_url
    self.asset = open(asset_remote_url) if asset_remote_url.present?
    # self.cover.clear if remove_cover == '1'
  rescue OpenURI::HTTPError
  end

  def change_file_name
    part = self.partner
    p part.inspect
    extension = File.extname(asset_remote_url.present? ? asset_remote_url : asset_file_name).gsub(/^\.+/, '')
    asset.instance_write(:file_name, "#{part ? part.slug : 'portfolio'}.#{extension}")
  end
end
