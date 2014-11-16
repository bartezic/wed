class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :involvings
  has_many :partners, through: :involvings

  has_attached_file :logo,
    styles: {
      thumb: '265x135#'
    },
    default_url: "/assets/ph/category_:attachment_:style.gif"

  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  before_validation :upload_logo_from_remote_url
  # before_save :change_file_name

  def upload_logo_from_remote_url
    self.logo = open(logo_remote_url) if logo_remote_url.present?
  rescue
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end
end
