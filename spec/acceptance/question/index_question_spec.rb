require 'spec_helper'
require 'rails_helper'

feature 'The user can view a list of questions', %q{
  the user sees the title of the questions 
} do

  given!(:question_list) {create_list :question, 3}

  scenario 'the user sees the title of the questions' do
    visit questions_path
    click_on 'All questions'

    expect(current_path).to eq questions_path
    question_list.each do |question|
      expect(page).to have_content question.title
    end
  end
end