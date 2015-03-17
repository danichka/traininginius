require 'rails_helper'

RSpec.describe Reply, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it 'validates presence of title' do 
    expect(Question.new(body:'question_body')).to_not be_valid
  end

  it 'validates presence of body' do 
    expect(Question.new(title:'question_name')).to_not be_valid
  end
end
