require 'rails_helper'

RSpec.feature 'Showing an Article' do
  
  before do
    @john = User.create(email: "john@example.com", password: "password")
    @fred = User.create(email: "fred@example.com", password: "password")
    @article = Article.create(title: "The first Article", body: "Body of first article", user: @john)
  end
  
  scenario 'display individual article' do
    visit '/'
    click_link @article.title
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page.current_path).to eq(article_path(@article))
  end
  
  scenario 'a non signed in user does not see edit or delete links' do
    visit '/'
    
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body) 
    expect(page.current_path).to eq(article_path(@article))
    expect(page).to_not have_link("Edit Article")
    expect(page).to_not have_link("Delete article")
  end
  
  scenario 'a non owner signed in can not see edi or delete links' do
    login_as(@fred)
    visit '/'
    
    click_link @article.title
    expect(page).to_not have_link("Edit Article")
    expect(page).to_not have_link("Delete article")
  end
  
  scenario 'signed in owner sees both links' do
    login_as(@john)
    visit '/'
    
    click_link @article.title
    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete article")    
  end
end