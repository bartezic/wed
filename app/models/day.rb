class Day < ActiveRecord::Base
  has_and_belongs_to_many :partners, join_table: :days_partners
end
