require 'spec_helper'
require 'rails_helper'

feature 'New answer', %q {
new
} do

  given(:user) { create(:user) }
  given(:question) { create(:question)}

  scenario 'create answer' do
    sign_in (user)
    visit question_path(question)

    fill_in 'Body', :with => 'Body answer'
    click_on 'Create Answer'

    expect(page).to have_content 'Body answer'
  end

  scenario 'create answer, unregistered user',js: true do
    visit question_path(question)

    expect(page).to have_content 'login or register to write a response'
  end

end