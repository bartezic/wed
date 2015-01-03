class Gallery < ActiveRecord::Base
  default_scope { order('position DESC, id DESC') }
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  belongs_to :partner
  has_many :photos, dependent: :destroy
  
  validates :name, presence: true
  
  accepts_nested_attributes_for :photos

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
  end
end
