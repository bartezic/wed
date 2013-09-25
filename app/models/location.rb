class Location < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug, use: :slugged

  translates :name
  has_many :lives_in, class_name: "Partner", foreign_key: "location_id"
  has_and_belongs_to_many :partners, :join_table => :locations_partners
end
