class Answer < ActiveRecord::Base
  default_scope { order(created_at: :asc) }
  belongs_to :question
  belongs_to :user

  validates :body, presence: true
  validates :question, presence: true
end