require 'rails_helper'

RSpec.feature "Deleting an Article" do
  
  before do
    john = User.create!(email:"john@example.com", password: "password")
    login_as(@john)
    @article = Article.create(title:"The First Article", body: "Body of first Article", user: john)
  end
  
  scenario 'a user deletes an article' do
    visit '/'
    click_link @article.title
    click_link "Delete article"
    
    expect(page).to have_content("You need to sign in or sign up before continuing")
    expect(page.current_path).to eq(new_user_session_path)
  end
end