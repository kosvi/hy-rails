class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery, touch: true
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user
  belongs_to :style

  validates :name, presence: true
  validates :style, presence: true

  def to_s
    "#{name} by #{brewery.name}"
  end

  def self.top(num)
    sorted_by_rating_in_desc_order = Beer.all.sort_by(&:average_rating).reverse!
    sorted_by_rating_in_desc_order.take(num)
  end

  def average
    return 0 if ratings.empty?

    ratings.map(&:score).sum / ratings.count.to_f
  end
end
