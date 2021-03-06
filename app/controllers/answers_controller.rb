class AnswersController < ApplicationController

  before_action :load_question, only: [:new, :create, :update, :destroy]
  before_action :load_answer, only: [:edit, :update, :destroy]

  def new
    @answer = Answer.new
  end

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    if @answer.update(answer_params)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to question_path(@question)
  end


  private 

  def load_answer
    @answer = Answer.find (params[:id])
  end

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:title, :body, :question_id)
  end
end