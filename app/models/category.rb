class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug, use: :slugged

  translates :name, :name_sing
end
