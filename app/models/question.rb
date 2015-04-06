class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers

  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true

end