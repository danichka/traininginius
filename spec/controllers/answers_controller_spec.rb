require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:answer) { create :answer }

  describe 'GET #new' do
    before { get :new}

    it "assigns a new answer to @answer" do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it { should render_template('new') }
  end


  describe 'GET #edit' do
    before{ get :edit, id: answer}

    it "assigns the requested answer to @answer" do
      expect(assigns(:answer)).to eq answer
    end

    it { should render_template('edit') }
  end


  describe 'POST #create' do
    context 'with valid attributes' do
      it 'seves the new answer in the db' do
        expect{ post :create, answer: attributes_for(:answer) }.to change(Answer,:count).by(1)
      end

      it 'redirects to show view' do
        post :create, answer: attributes_for(:answer)
        expect(response).to redirect_to answer_path(assigns(:answer))
      end
    end
  
    context 'with invalid attr' do
      it 'does not save new answer in database' do
        expect { post :create, answer: attributes_for(:invalid_answer) }.to_not change(Answer, :count)
      end

      it 're-render new view' do
        post :create, answer: attributes_for(:invalid_answer)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do 

    context 'with valid attr' do
      it 'assigns the requested answer with @answer' do
        patch :update, id: answer, answer: attributes_for(:answer)
        expect(assigns(:answer)).to eq answer
      end

      it 'change attr' do
        patch :update, id: answer, answer: { title: "Test title", body: "Test body" }
        answer.reload
        expect(answer.title).to eq "Test title"
        expect(answer.body).to eq "Test body"
      end

      it 'redirect to the updated answer' do
        patch :update, id: answer, answer: attributes_for(:answer)
        expect(response).to redirect_to answer
      end
    end

    context 'with invalid attr' do
      before { patch :update, id: answer, answer: { title: "test title", body: nil } }

      it 'does not change que attr' do
        answer.reload
        expect(answer.title).to eq "Name title"
        expect(answer.body).to eq "Body text"
      end

      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end 
  end

  describe 'DELETE #destroy' do
    before { answer } 

    it 'delete answer from database' do
       expect { delete :destroy, id: answer }.to change(Answer, :count).by(-1)
     end

    it 'redirect to index view' do
      delete :destroy, id: answer
      expect(response).to redirect_to question_path
    end
  end



end
