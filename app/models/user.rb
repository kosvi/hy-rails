class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 30 }
  # found quite pretty way to handle password requirements:
  #   https://medium.com/@Timothy_Fell/how-to-set-password-requirements-in-rails-d9081926923b
  PASSWORD_REQUIREMENTS = /\A(?=.{4,})(?=.*[a-z])(?=.*[A-Z])/x
  validates :password, format: PASSWORD_REQUIREMENTS

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, -> { where confirmed: true }, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?

    # beers.group(:style).average('ratings.score').sort_by { |style, avg| avg }.last.first()
    beers.group(:style).average('ratings.score').max_by { |_style, avg| avg }.first.name
  end

  def favorite_brewery
    return nil if ratings.empty?

    # favorites = beers.group(:brewery).average('ratings.score').sort_by { |_brewery, avg| avg }
    beers.group(:brewery).average('ratings.score').max_by { |_brewery, avg| avg }.first.name
  end

  def self.most_ratings(num)
    sorted_by_number_of_ratings_in_desc_order = User.all.sort_by{ |u| u.ratings.count }.reverse!
    sorted_by_number_of_ratings_in_desc_order.take(num)
  end
end
