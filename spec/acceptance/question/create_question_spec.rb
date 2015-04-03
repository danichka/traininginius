require 'spec_helper'
require 'rails_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask the question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question)}

  before do
    sign_in user
    visit questions_path
    click_on 'Ask question'
  end
  scenario 'Authenticated user create the question' do
    fill_in 'Title', with: 'Title'
    fill_in 'Body', with: 'Body'
    click_on 'Create'

    expect(page).to have_content 'Title'
  end

  scenario 'Non-authenticated user try to create question' do
    visit '/questions'
    click_on 'Ask question'

    expect(page).to have_content 'Ask your question'
  end

  scenario ' User can view the question' do
    visit questions_path (question)

    expect(page).to have_content question.title

  end

end