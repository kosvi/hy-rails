class BeerClub < ApplicationRecord
  has_many :memberships, -> { where confirmed: true }
  has_many :users, through: :memberships

  def to_s
    "#{name} from #{city}"
  end
end
