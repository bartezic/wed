class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  translates :name, :name_sing
  has_and_belongs_to_many :partners, :join_table => :categories_partners

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end
end
