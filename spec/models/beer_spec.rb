require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe "with a proper brewery" do
    let(:brewery) { FactoryBot.create(:brewery) }

    it "is saved if other properties are given correctly" do
      beer = Beer.create name: "Name", style: "Style", brewery: brewery
  
      expect(beer.valid?).to be(true)
      expect(Beer.count).to eq(1)
    end
  
    it "is not saved if name is missing" do 
      beer = Beer.create style: "Style", brewery: brewery

      expect(beer.valid?).to be(false)
      expect(Beer.count).to eq(0)
    end

    it "is not saved if style is missing" do
      beer = Beer.create name: "Name", brewery: brewery

      expect(beer.valid?).to be(false)
      expect(Beer.count).to eq(0)
    end
  end
end
