require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe 'GET #new' do
    before { get :new, question_id: question}

    it "assigns a new answer to @answer" do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it { should render_template('new') }
  end


  describe 'GET #edit' do
    before { get :edit, question_id: question, id: answer }

    it "assigns the requested answer to @answer" do
      expect(assigns(:answer)).to eq answer
    end

    it { should render_template('edit') }
  end


  describe 'POST #create' do
    context 'with valid attributes' do

      it 'saves the new answer in the database' do
        expect { post :create, question_id: question, answer: attributes_for(:answer) }.to change(question.answers, :count).by(1)
      end

      it 'redirect to question' do
        post :create, question_id: question, answer: attributes_for(:answer)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end
  
    context 'with invalid attr' do
      it 'does not save new answer in database' do
        expect { post :create,question_id: question, answer: attributes_for(:invalid_answer) }.to_not change(Answer, :count)
      end

      it 'render new view' do
        post :create,question_id: question, answer: attributes_for(:invalid_answer)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do 

    context 'with valid attr' do
      it 'assigns the requested answer with @answer' do
        patch :update,question_id: question, id: answer, answer: attributes_for(:answer)
        expect(assigns(:answer)).to eq answer
      end

      it 'change attr' do
        patch :update,question_id: question, id: answer, answer: { title: "Test title", body: "Test body" }
        answer.reload
        expect(answer.title).to eq "Test title"
        expect(answer.body).to eq "Test body"
      end

      it 'redirect to the updated answer' do
        patch :update,question_id: question, id: answer, answer: attributes_for(:answer)
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attr' do
      before { patch :update,question_id: question, id: answer, answer: { title: "test title", body: nil } }

      it 'does not change que attr' do
        answer.reload
        expect(answer.title).to eq "Name title"
        expect(answer.body).to eq "Body answer"
      end

      it 'render edit view' do
        expect(response).to render_template :edit
      end
    end 
  end

  describe 'DELETE #destroy' do

    it 'delete answer from database' do
    answer
    expect{ delete :destroy, id: answer, question_id: question}.to change(Answer,:count).by(-1)
    end

    it 'assigns question to @question' do
      delete :destroy, id: answer, question_id: question
      expect(response).to redirect_to question_path(question)
    end
  end



end
