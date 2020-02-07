class Vaccination < ActiveRecord::Base
  belongs_to :pet
  validates :vacc_name, presence: true
  validates :date_given, presence: true
end