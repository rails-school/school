class AnswersController < ApplicationController
  def create
    @answer = Answer.new(params[:answer])
    @answer.save!

  end
  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
  end
end
