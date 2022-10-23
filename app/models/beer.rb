class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings

  def average_rating
    count = self.ratings.count
    if count > 0
      self.ratings.map {|r| r.score}.inject {|sum, num| sum + num} / count
    end
  end
end
