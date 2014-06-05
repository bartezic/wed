class Manager < ActiveRecord::Base
  has_one :user, as: :rolable, dependent: :destroy

  accepts_nested_attributes_for :user
end
