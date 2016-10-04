class Cat < ActiveRecord::Base
  validates :name, :sex, :color, presence: true
end
