require 'spec_helper'
require 'rails_helper'


feature 'delete question', %q {
delete
} do

  given(:user) { create(:user) }
  given(:author) { create(:user) }
  given!(:question) { create(:question, user: author) }

  scenario 'button dellete question' do
    sign_in(author)
    visit questions_path(question)
    click_on 'delete the question'

    expect(current_path).to eq questions_path
    # expect(page).to_not have_content 'Name title'
  end

  scenario 'Authenticated user, but not the author of question tries to delete it' do
    sign_in(user)

    visit question_path(question)
    expect(page).to_not have_content 'delete the question'
  end
end