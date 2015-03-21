FactoryGirl.define do

  factory :question do
    title "Name title"
    body "Body text"
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
  end

end
