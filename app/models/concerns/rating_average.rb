module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    count = ratings.count
    return unless count > 0

    ratings.map(&:score).inject { |sum, num| sum + num } / count
  end
end
