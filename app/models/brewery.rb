class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validate :year_cannot_be_in_future
  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1040, only_integer: true }

  def to_s
    name
  end

  def restart
    self.year = Date.current.year
    puts "changed year to #{year}"
  end

  def year_cannot_be_in_future
    return unless year > Time.now.year

    errors.add(:year, "can't be in the future")
  end
end
