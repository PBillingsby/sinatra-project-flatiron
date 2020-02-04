class Pet < ActiveRecord::Base
  belongs_to :user
  has_many :vaccinations

  # def select_pet_attributes
  #   .select {|obj| ...... }
  # end
end