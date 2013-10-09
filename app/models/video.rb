class Video < ActiveRecord::Base
  belongs_to :partner
  translates :name, :description
end
