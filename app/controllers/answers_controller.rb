class AnswersController < ApplicationController
  before_action :set_question!

  def create
    @answer = @question.answers.build answer_params

    if @answer.save
      flash[:success] = "Комментарий удален!"
      redirect_to question_path(@question)
    else
      @answers = @question.answers.order created_at: :desc
      render 'questions/show'
    end
  end

  def edit
    @answer = @question.answers.find params[:id]
  end

  def update
    @answer = @question.answers.find params[:id]
    if @answer.update answer_params
      flash[:success] = "Комментарий обновлен!"
      redirect_to question_path(@question), status: :see_other
    else
      render :edit
    end
  end

  def destroy
    answer = @question.answers.find params[:id]
    answer.destroy
    flash[:success] = "Комментарий удален!"
    redirect_to question_path(@question), status: :see_other
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question!
    @question = Question.find params[:question_id]
  end
end