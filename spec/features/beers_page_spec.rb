require 'rails_helper'

include Helpers

describe "Beer" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }

  it "with a valid name is created and stored" do
    visit new_beer_path
    fill_in('beer[name]', with: 'kalja')
    select('IPA', from: 'beer[style]')
    
    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)

    expect(page).to have_content "Beer was successfully created."
    expect(page).to have_content "Name: kalja"
    expect(page).to have_content "Style: IPA"
  end

  it "is not stored if name is not valid" do
    visit new_beer_path

    expect{
      click_button "Create Beer"
    }.not_to change{Beer.count}.from(0)

    expect(page).to have_content "Name can't be blank"
  end
end
