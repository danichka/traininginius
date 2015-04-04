FactoryGirl.define do


  factory :answer do
    title "Name title"
    body "Body answer"
  end

  factory :invalid_answer, class: "Answer" do
    title nil
    body nil
  end
end
