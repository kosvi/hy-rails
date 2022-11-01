class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def to_s
    self.name
  end

  def restart
    self.year = Date.current.year
    puts "changed year to #{self.year}"
  end
end
