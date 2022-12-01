class BeerClub < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships

  def to_s
    "#{name} from #{city}"
  end
end
