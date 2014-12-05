class Cooperation < ActiveRecord::Base
  belongs_to :partner
  belongs_to :co, class_name: 'Partner'
end
