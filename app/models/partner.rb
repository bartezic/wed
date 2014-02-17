class Partner < ActiveRecord::Base
  # default_scope { order('partners.id DESC') }
  belongs_to :location
  has_one :user, as: :rolable, dependent: :destroy
  has_many :videos
  has_many :photos, through: :galleries
  has_many :galleries
  has_many :slider_ads
  has_many :partner_ads
  has_and_belongs_to_many :locations,  join_table: :locations_partners
  has_and_belongs_to_many :categories, join_table: :categories_partners
  has_and_belongs_to_many :days,       join_table: :days_partners

  accepts_nested_attributes_for :galleries
  accepts_nested_attributes_for :user

  extend FriendlyId
  friendly_id :name, use: :slugged
  
  paginates_per 36
  translates :name, :description, :info

  scope :active,          -> { where(active: true) }
  scope :with_category,   -> (ids) { joins(:categories).where("categories.id IN (?)", ids) unless ids.blank? }
  scope :with_location,   -> (ids) { joins(:locations).where("locations.id IN (?)", ids) unless ids.blank? }
  scope :with_ids,        -> (ids) { where('partners.id IN (?)', ids) unless ids.blank? }
  scope :without_ids,     -> (ids) { where('partners.id NOT IN (?)', ids) unless ids.blank? }

  # scope :with_day,        -> (id) { includes(:days).where('days.id != ?', id) if id } 
  # scope :recommended,     lambda { |i| where(recommended: true) if i }
  # scope :with_days,       joins(:days)
  # scope :with_from,       lambda { |ids| joins(:regions).where("regions.id IN (?)",           ids) unless ids.blank? }
  # scope :with_transports, lambda { |ids| joins(:transports).where("transports.id IN (?)",     ids) unless ids.blank? }
  # scope :with_tour_types, lambda { |ids| joins(:tour_types).where("tour_types.id IN (?)",     ids) unless ids.blank? }
  # scope :with_countries,  lambda { |ids| with_regions(Region.where('country_id IN (?)', ids).map(&:id)) unless ids.blank? }
  # scope :with_regions,    lambda { |ids| 
  #   with_ids(Region.where('id IN (?)', ids).includes(&:tour_programs).map{ |region|
  #     region.tour_programs.map(&:tour_id)
  #   }.flatten) unless ids.blank?
  # }
  # scope :with_query,      lambda { |query| where("tours.title ilike ? or tours.description ilike ?", "%#{query}%", "%#{query}%") unless query.blank? }

  def self.search(params, order, ids = []) 
    includes(:translations).
      active.
      without_ids(day_partners(params)).
      with_category(params[:category_ids]).
      with_location(params[:location_ids]).
      order("partners.#{order}").
      uniq.
      page(params[:page] || 0)
  end

  def self.day_partners(params)
    if params[:date] && !params[:date].empty? 
      day = Day.find_by_day_of_life(Date.strptime(params[:date], "%d/%m/%Y"))
      partners_ids = day.partners.pluck(:id) if day
    end
    partners_ids || []
  end
  
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
