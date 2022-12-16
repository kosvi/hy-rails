class Style < ApplicationRecord
  has_many :beers

  def to_s
    name
  end
end
