class AnswerController < ApplicationController

    def new
      @question = Question.find(params[:question_id])
      @answer = @question.answers.new
    end

    def create 
      @question = Question.find(params[:question_id])
      
      answer = @question.answers.new(answer_params)
      answer.user_id = current_user.id
      
      
      if answer.save
        redirect_to answer.question
      else
        render :new
      end
    end

    def destroy
      answer = Answer.find(params[:id])
      if answer.user_id == current_user.id
        Answer.find(params[:id]).destroy
        redirect_to question_path(question.id)
      else
        render inline: p= '???'
      end
    end


    private

    def answer_params
        params.require(:answer).permit(:body, :user_id)
    end

end
