class AnswerController < ApplicationController

    def new
      @question = Question.find(params[:question_id])
      @answer = @question.answers.new
    end

    def create 
      @question = Question.find(params[:question_id])
      
      answer = @question.answers.new(answer_params)
      answer.user_id = current_user.id
      answer.save
    end

    def destroy
      @question = Question.find(params[:question_id])
      answer = Answer.find(params[:id])
      if answer.user_id == current_user.id
        Answer.find(params[:id]).destroy
        redirect_to question_path(@question)
      else
        render inline: p= '???'
      end
    end

    def destroy_all
      @question = Question.find(params[:question_id])
      answers = Answer.find_all(params[:id])
      if answer.user_id == current_user.id
        Answer.find(params[:id]).destroy_all
      else
        render inline: p= '???'
      end
    end


    private

    def answer_params
        params.require(:answer).permit(:body, :user_id)
    end

end
