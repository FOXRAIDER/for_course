class QuestionsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :load_question, only: [:show, :edit, :update, :destroy]
    
    def index
        @questions = Question.all
    end
    
    def show
        
    end
    def new
        @question = Question.new
        @question.user_id = current_user.id 
    end 
    def edit
             
    end

    def create
        @question = Question.new(question_params)
        if @question.save 
            redirect_to @question
        else
            render :new    
        end
    end

    def update
        if @question.update(question_params)
            redirect_to @question
        else
            render :edit
        end
    end

    def destroy
        if @question.user_id == current_user.id
            Question.find(params[:id]).destroy
            redirect_to root_path
        else
            render inline: p='Вы не можете удалить данный вопрос'
            end
    end

    def destroy_all
        
        Answer.where(question_id = @question).destroy_all
        question = Question.find(params[:id])
        redirect_to question_path(question)
    end

    private

    def load_question
        @question = Question.find(params[:id])     
    end

    def question_params
        params.require(:question).permit(:title, :body, :user_id)
    end

end
