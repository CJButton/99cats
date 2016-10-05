class Cat < ActiveRecord::Base
  validates :name, :sex, :color, presence: true

  has_many :cat_rental_requests, dependent: :destroy

  def age
    Time.now.year - self.birth_date.year
  end
end
