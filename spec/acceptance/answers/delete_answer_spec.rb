require 'rails_helper'

feature 'Delete answer', %q{
  delete
} do

  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: author) }
  given!(:answer) { create(:answer, question: question, user: author)}

  scenario 'Authenticated user and an author of answer tries to delete it' do
    sign_in(author)

    visit question_path(question)
    save_and_open_page
    click_on 'delete the answer'

    expect(current_path).to eq question_path(question)
    
    expect(page).to_not have_content 'Body answer'
  end

  scenario 'Authenticated user, but not the author of answer tries to delete it' do
    sign_in(user)

    visit question_path(question)
    expect(page).to_not have_content 'delete the answer'
  end

end