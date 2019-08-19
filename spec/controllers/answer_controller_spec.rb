require 'rails_helper'

RSpec.describe AnswerController, type: :controller do
    let(:question) { create(:question) }
    describe 'GET #new' do
        before do 
            get :new, params: {question_id: question}
        end
        it 'assigns a new answer for questions' do
            expect(assigns(:answer)).to be_a_new(Answer)    
        end 

        it 'render new view' do
            expect(response).to render_template :new
        end
    end

    describe 'POST #create' do 
        context 'valid attributes' do
            it 'save answer' do
                expect {post :create, params:{question_id: question, answer: attributes_for(:answer)}}.to change(question.answers, :count).by(1)
            end
            it 'redirect' do
                post :create, params: { question_id: question, answer: attributes_for(:answer)}
                expect(response).to redirect_to question_path(question)
            end
        end

        context 'invalid attributes' do
            it 'doesnt save' do
                expect {post :create, params:{question_id: question, answer: attributes_for(:invalid_answer)}}.to_not change(question.answers, :count)
            end
    
            it 'render new view' do
                post :create, params: { question_id: question, answer: attributes_for(:invalid_answer)}
                expect(response).to render_template :new
            end
        end
    end

end
