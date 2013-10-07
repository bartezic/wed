class Video < ActiveRecord::Base
  belongs_to :partner
  translates :name, :description

  has_attached_file :cover,
    :styles => { 
      :thumb_150 => ['150x110#', :jpg]
    },
    :convert_options => { 
      :thumb_150 => "-interlace Plane"
    },
    :default_url => "/assets/ph/:attachment_:style.gif", 
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"

  before_save :upload_cover_from_remote_url
  before_save :change_file_name

  def upload_cover_from_remote_url
    self.cover = open(cover_remote_url) if cover_remote_url.present?
    # self.cover.clear if remove_cover == '1'
  rescue OpenURI::HTTPError
  end

  def change_file_name
    # part = self.partner
    # vname = self.name.to_slug.normalize(transliterations: :ukrainian).to_s
    extension = File.extname(cover_remote_url.present? ? cover_remote_url : cover_file_name).gsub(/^\.+/, '')
    cover.instance_write(:file_name, "#{self.partner.slug}.#{extension}")
  end
end
