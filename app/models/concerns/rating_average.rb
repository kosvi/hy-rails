module RatingAverage
  extend ActiveSupport::Concern

  module ClassMethods
    def top(how_many)
      sorted_by_rating_in_desc_order = all.sort_by(&:average_rating).reverse!
      sorted_by_rating_in_desc_order.take(how_many)
    end
  end

  def average_rating
    count = ratings.size
    return 0 unless count > 0

    ratings.map(&:score).inject { |sum, num| sum + num } / count
  end
end
