class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params)
    @answer.save!
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
  end

  private
  def answer_params
    params.require(:answer).permit(:poll_id, :text)
  end
end
