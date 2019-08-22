class AnswerController < ApplicationController

    def new
        @answer = Answer.new
    end

    def create
        
        question = Question.find(params[:question_id])
        
        answer = question.answers.new(answer_params)
        
        
        if answer.save
          redirect_to answer.question
        else
          render :new
        end
    end

    def destroy
      @answer.destroy
      redirect_to @question
    end


    private

    def answer_params
        params.require(:answer).permit(:body)
    end
end
