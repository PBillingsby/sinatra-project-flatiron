class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true
  validates :email, confirmation: true
  has_many :pets
end