class Brewery < ApplicationRecord
  has_many :beers

  def restart
    self.year = Date.current.year
    puts "changed year to #{self.year}"
  end
end
