require 'rails_helper'

RSpec.feature 'User signin' do
  
  before do
    @john = User.create(email: "john@example.com", password: "password")
  end
  
  scenario 'sign in with valid credentials' do
    visit "/"
    
    click_link "Sign In"
    fill_in "Email", with: "john@example.com"
    fill_in "Password", with: "password"
    click_button "Log in"
    
    expect(page).to have_content("Signed in successfully")
    expect(page).to have_content("Signed in as #{@john.email}")
  end
end