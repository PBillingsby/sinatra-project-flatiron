class Pet < ActiveRecord::Base
  belongs_to :user
  has_many :vaccinations
  validates :name, presence: true
end