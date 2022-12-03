class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 30 }
  # found quite pretty way to handle password requirements: 
  #   https://medium.com/@Timothy_Fell/how-to-set-password-requirements-in-rails-d9081926923b
  PASSWORD_REQUIREMENTS = /\A(?=.{4,})(?=.*[a-z])(?=.*[A-Z])/x
  validates :password, format: PASSWORD_REQUIREMENTS

  has_many :ratings
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships
end
