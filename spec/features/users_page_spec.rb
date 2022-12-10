require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    @user = FactoryBot.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      # visit signin_path
      # fill_in('username', with: 'Pekka')
      # fill_in('password', with: 'Foobar1')
      # click_button('Log in')
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      # visit signin_path
      # fill_in('username', with: 'Pekka')
      # fill_in('password', with: 'wrong')
      # click_button('Log in')
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username or password incorrect!'
    end

    it "can delete own rating from database" do
      create_beers_with_many_ratings({ user: @user }, 10, 15, 20)
      sign_in(username: "Pekka", password: "Foobar1")
      
      expect{
        page.all(:css, 'a.delete-rating-btn')[1].click
      }.to change{Rating.count}.from(3).to(2)
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')
  
    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "when viewed will display favorite style and brewery" do
    brewery = FactoryBot.create(:brewery, name: "SuperBrew")
    create_beers_with_many_ratings({ user: @user, brewery: brewery }, 10, 15, 20)
    visit user_path(@user)

    expect(page).to have_content "beer style: Lager"
    expect(page).to have_content "brewery: SuperBrew"
  end
end
