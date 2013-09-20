class Location < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug, use: :slugged

  translates :name
end
