require 'rails_helper'

describe "Beerlist page" do
  before :all do
    Capybara.register_driver :chrome do |app|
      Capybara::Selenium::Driver.new app, browser: :chrome,
        options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu])
    end

    Capybara.javascript_driver = :chrome
    WebMock.allow_net_connect!
  end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name: "Koff")
    @brewery2 = FactoryBot.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryBot.create(:beer, name: "Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryBot.create(:beer, name: "Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryBot.create(:beer, name: "Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  it "shows one known beer", js:true do
    visit beerlist_path
    #find('table').find('tr:nth-child(2)')
    expect(page).to have_content "Nikolai"
  end

  it "should list beers by name", js:true do
    visit beerlist_path
    rows = find("#beertable").all(".tablerow")
    first = rows[0].first("td")
    second = rows[1].first("td")
    third = rows[2].first("td")
    expect(first.text).to eq("Fastenbier")
    expect(second.text).to eq("Lechte Weisse")
    expect(third.text).to eq("Nikolai")
  end

  it "should be able to sort by style", js:true do
    visit beerlist_path
    find("#style").click()
    rows = find("#beertable").all(".tablerow")
    # I think a helper could be useful here...
    first = rows[0].first("td")
    second = rows[1].first("td")
    third = rows[2].first("td")
    expect(first.text).to eq("Nikolai")
    expect(second.text).to eq("Fastenbier")
    expect(third.text).to eq("Lechte Weisse")
  end

  it "should be able to sort by brewery", js:true do
    visit beerlist_path
    find("#brewery").click()
    rows = find("#beertable").all(".tablerow")
    first = rows[0].first("td")
    second = rows[1].first("td")
    third = rows[2].first("td")
    expect(first.text).to eq("Lechte Weisse")
    expect(second.text).to eq("Nikolai")
    expect(third.text).to eq("Fastenbier")
  end
end
