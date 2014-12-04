class Partner < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  paginates_per 24

  belongs_to :location
  has_one :user, as: :rolable, dependent: :destroy
  has_many :videos
  has_many :galleries
  has_many :slider_ads
  has_many :involvings
  has_many :categories, through: :involvings
  has_many :photos,     through: :galleries
  has_and_belongs_to_many :locations,  join_table: :locations_partners
  has_and_belongs_to_many :days,       join_table: :days_partners

  accepts_nested_attributes_for :involvings, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :galleries
  accepts_nested_attributes_for :user

  # default_scope { order('partners.id DESC') }  
  scope :active,          -> { where(active: true) }
  scope :with_category,   -> (ids) { joins(:categories).where("categories.id IN (?)", ids) unless ids.blank? }
  scope :with_location,   -> (ids) { joins(:locations).where("locations.id IN (?)", ids) unless ids.blank? }
  scope :with_ids,        -> (ids) { where('partners.id IN (?)', ids) unless ids.blank? }
  scope :without_ids,     -> (ids) { where('partners.id NOT IN (?)', ids) unless ids.blank? }

  after_save do |partner|
    bool = partner.profile_filled? && partner.categories.any?
    partner.update_column(:active, bool) unless partner.active? == bool
  end

  def self.search(params, order, ids = []) 
    active.
      without_ids(day_partners(params)).
      with_location(params[:location_id]).
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

  def price_for(category)
    involvings.where(category_id: category.id).first.price
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

  def count_profile_filling
    count = 0
    count += 5 if self.name.present?
    count += 5 if self.description.present?
    count += 5 if self.info.present?
    count += 5 if self.categories.any?
    count += 5 if self.locations.any?

    count += 10 if self.user.avatar.exists?
    count += 10 if self.user.email && self.user.confirmed?
    count += 5 if self.location.present?
    count += 5 if self.site.present?
    count += 10 if self.phone.present?
    count += 10 if self.galleries.any? && self.photos.any?
    count += 10 if self.videos.any?
    count
  end

  def profile_filled?
    self.count_profile_filling >= 75
  end
end