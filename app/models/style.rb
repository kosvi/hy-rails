class Style < ApplicationRecord
  include RatingAverage

  has_many :beers
  has_many :ratings, through: :beers

  def to_s
    name
  end

  def self.top(num)
    sorted_by_rating_in_desc_order = Style.all.sort_by(&:average_rating).reverse!
    sorted_by_rating_in_desc_order.take(num)
  end
end
