class SliderAd < ActiveRecord::Base
  belongs_to :partner

  has_attached_file :asset,
    :styles => { 
      :thumb => ['140x50#', :jpg],
      :slide => ['1400x500#', :jpg]
    },
    :convert_options => { 
      :thumb => "-interlace Plane",
      :slide => "-interlace Plane"
    },
    :default_url => "/assets/ph/:attachment_:style.gif", 
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"

  validates_attachment_content_type :asset, :content_type => /\Aimage\/.*\Z/

  before_validation :upload_asset_from_remote_url
  # before_save :change_file_name

  def upload_asset_from_remote_url
    self.asset = open(asset_remote_url) if asset_remote_url.present?
    # self.cover.clear if remove_cover == '1'
  rescue OpenURI::HTTPError
  end
end
