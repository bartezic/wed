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
  # before_save :change_file_name

  def upload_asset_from_remote_url
    self.asset = open(asset_remote_url) if asset_remote_url.present?
    # self.cover.clear if remove_cover == '1'
  rescue OpenURI::HTTPError
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end

  # def change_file_name
  #   cat = self.categories.first
  #   extension = File.extname(avatar_remote_url.present? ? avatar_remote_url : avatar_file_name).gsub(/^\.+/, '')
  #   name = self.name.to_slug.normalize(transliterations: :ukrainian).to_s
  #   name = "#{name}_#{cat.slug}" if cat
  #   avatar.instance_write(:file_name, "#{name}.#{extension}")
  # end
end
