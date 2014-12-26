class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  default_scope { order('id ASC') }

  has_many :involvings
  has_many :partners, through: :involvings

  has_attached_file :logo,
    styles: { thumb: '265x135#' },
    convert_options: { thumb: '-quality 100' },
    default_url: "/assets/ph/category_:attachment_:style.gif"

  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  attr_reader :logo_remote_url
  # before_validation :upload_logo_from_remote_url
  # before_save :change_file_name

  # def upload_logo_from_remote_url
  #   self.logo = URI.parse(logo_remote_url) if logo_remote_url.present?
  # rescue
  # end

  def logo_remote_url=(url_value)
    self.logo = URI.parse(url_value)
    # Assuming url_value is http://example.com/photos/face.png
    # avatar_file_name == "face.png"
    # avatar_content_type == "image/png"
    @logo_remote_url = url_value
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end
end
