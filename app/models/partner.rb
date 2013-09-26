class Partner < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :location
  has_and_belongs_to_many :locations,   :join_table => :locations_partners
  has_and_belongs_to_many :categories,  :join_table => :categories_partners

  translates :name, :description, :info
  
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

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
  before_save :change_file_name

  def upload_avatar_from_remote_url
    self.avatar = open(avatar_remote_url) if avatar_remote_url.present?
    # self.cover.clear if remove_cover == '1'
  rescue OpenURI::HTTPError
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end

  def change_file_name
    cat = self.categories.first
    extension = File.extname(avatar_remote_url.present? ? avatar_remote_url : avatar_file_name).gsub(/^\.+/, '')
    name = self.name.to_slug.normalize(transliterations: :ukrainian).to_s
    name = "#{name}_#{cat.slug}" if cat
    avatar.instance_write(:file_name, "#{name}.#{extension}")
  end
end
