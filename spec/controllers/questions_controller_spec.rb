require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
    let(:question) { create(:question) }


    describe 'GET #index' do
        let(:questions) { create_list(:question, 2) }
        before { get :index }

        it 'populates an array of all questions' do
            expect(assigns(:questions)).to match_array(@questions)
        end

        it 'renders index view' do
            expect(response).to render_template :index
        end
    end

    describe 'GET #show' do

        before do
            get :show, params: { id: question.id}
        end
        it 'assings the requested question  to @question' do 
            expect(assigns(:question)).to eq question
        end
        it 'renders show view' do 
            expect(response).to render_template :show
        end
    end

    describe 'GET #new' do
        sign_in_user 
        before {get :new}
        it 'assigns a new question to @question' do
            expect(assigns(:question)).to be_a_new(Question)
        end

        it 'renders new view' do
            expect(response).to render_template :new
        end
    end

    describe 'GET #edit' do
        sign_in_user
        before do
            get :edit, params: { id: question.id}
        end
        
        it 'assings the requested question  to @question' do 
            expect(assigns(:question)).to eq question
        end

        it 'renders new view' do
            expect(response).to render_template :edit
        end

    end

    describe 'POST #create' do
        sign_in_user
        context 'with valid attributes' do
            it 'saves the new questions in the database' do
                expect {post :create, params:{question: attributes_for(:question)}}.to change(Question, :count).by(1)
            end

            it 'redirects to show view' do
                post :create, params:{question: attributes_for(:question)}
                expect(response).to redirect_to question_path(assigns(:question))
            end
        end

        context 'with invalid attributes' do
            it  'doesnt save the questions' do
                expect {post :create, params:{question: attributes_for(:invalid_question)}}.to_not change(Question, :count)
            end
            it 'rerenders new view' do
                post :create, params:{question: attributes_for(:invalid_question)}
                expect(response).to render_template :new 
            end
        end
    end

    describe 'PATCH #update' do
        sign_in_user
        context 'valid attributes' do
            it 'assings the requested question  to @question' do 
                patch :update, params: { id: question, question: attributes_for(:question)}
                expect(assigns(:question)).to eq question
            end
            it 'changes question attributes' do
                patch :update, params: {id: question, question:{title: "new title", body:"new body"}}
                question.reload
                expect(question.title).to eq 'new title'
                expect(question.body).to eq 'new body'
            end

            it 'redirects to the updated questions' do
                patch :update, params: { id: question, question: attributes_for(:question)}
                expect(response).to redirect_to question
            end
        end 

        context 'invalid attributes' do 
            before {patch :update, params: {id: question, question:{title: "new title", body:""}}}
            
            it 'doesnt changes question attributes' do
                question.reload
                expect(question.title).to eq 'MyString'
                expect(question.body).to eq 'MyText'
            end

            it 'rerender edit view' do
                expect(response).to render_template :edit
            end
        end
    end

    describe 'DELETE #destroy' do
        sign_in_user
        before {question}
        it 'deletes question' do
            expect {delete :destroy, params: {id: question}}.to change(Question, :count).by(-1)
        end
        it 'redirect to index' do
            delete :destroy, params: {id: question}
            expect(response).to redirect_to question_path
        end 
    end

end
