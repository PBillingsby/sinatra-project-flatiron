class User < ActiveRecord::Base
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :password, length: { minimum: 6}
  validates :username, presence: true
  validates :email, format: VALID_EMAIL_REGEX
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  has_many :pets
end