class Partner < ActiveRecord::Base
  belongs_to :location
  has_one :user, as: :rolable, dependent: :destroy
  has_many :videos
  has_many :galleries
  has_and_belongs_to_many :locations,  join_table: :locations_partners
  has_and_belongs_to_many :categories, join_table: :categories_partners
  has_and_belongs_to_many :days,       join_table: :days_partners

  accepts_nested_attributes_for :galleries
  accepts_nested_attributes_for :user

  extend FriendlyId
  friendly_id :name, use: :slugged
  
  paginates_per 36
  translates :name, :description, :info
  
  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end

  def calendar
    mon = Date::MONTHNAMES.compact
    b = {}
    a = days.sort_by(&:day_of_life).map { |p| p.day_of_life }
    a.each {|i| b[i.year] = {}}
    a.each {|i| b[i.year][i.mon] = []}
    a.each {|i| b[i.year][i.mon] << i.day}
    b if b.any?
  end
end
