
  given(:user) { create(:user) }
  given(:author) { create(:user) }
  given!(:question) { create(:question, user: author) }

  scenario 'button dellete question' do
    sign_in(author)
    visit questions_path(question)
    click_on 'delete the question'

    expect(current_path).to eq questions_path
    expect(page).to_not have_content 'Name title'
  end
