class Location < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :lives_in, class_name: "Partner", foreign_key: "location_id"
  has_and_belongs_to_many :partners, :join_table => :locations_partners
  
  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end
end
