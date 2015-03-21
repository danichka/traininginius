require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create :question }
  describe 'GET #index' do

    let(:questions) { create_list(:question, 2) }
    before { get :index} 

    it" populates an array of all questions " do
      expect(assigns(:questions)).to  match_array(questions)
    end

    it { should render_template('index') }
  end

  describe 'GET #show' do

    before { get :show, id: question }

    it "assigns the requested question to @question" do
      expect(assigns(:question)).to eq question
    end

    it { should render_template('show') }
  end

  describe 'GET #new' do
    before { get :new}

    it "assigns a new question to @question" do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it { should render_template('new') }
  end

  describe 'GET #edit' do
    before{ get :edit, id: question}

    it "assigns the requested question to @question" do
      expect(assigns(:question)).to eq question
    end

    it { should render_template('edit') }
  end


  describe 'POST #create' do
    context 'with valid attributes' do
      it 'seves the new question in the db' do
        expect{ post :create, question: attributes_for(:question) }.to change(Question,:count).by(1)
      end

      it 'redirects to show view' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end
  
    context 'with invalid attr' do
      it 'does not save new question in database' do
        expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it 're-render new view' do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do 

    context 'with valid attr' do
      it 'assigns the requested question with @question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(assigns(:question)).to eq question
      end

      it 'change attr' do
        patch :update, id: question, question: { title: "Test title", body: "Test body" }
        question.reload
        expect(question.title).to eq "Test title"
        expect(question.body).to eq "Test body"
      end

      it 'redirect to the updated question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attr' do
      before { patch :update, id: question, question: { title: "test title", body: nil } }
      
      it 'does not change que attr' do
        question.reload
        expect(question.title).to eq "Name title"
        expect(question.body).to eq "Body text"
      end

      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end 
  end

  describe 'DELETE #destroy' do
    before { question } 

    it 'delete question from database' do
       expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
     end

    it 'redirect to index view' do
      delete :destroy, id: question
      expect(response).to redirect_to questions_path
    end
  end


end
