class QuestionsController < ApplicationController
  before_action :require_authentication, expect: %i[show index]
  before_action :set_question!, only: %i[show destroy edit update]
  before_action :authorize_question!
  after_action :verify_authorized

  def show
    @answer = @question.answers.build
    @pagy, @answers = pagy @question.answers.order(created_at: :desc)
  end

  def destroy
    @question.destroy
    flash[:success] = "Статья удалена!"
    redirect_to root_path, status: :see_other
  end

  def edit
  end

  def update
    if @question.update question_params
      flash[:success] = "Статья обновлена!"
      redirect_to questions_path
    else
      render :edit
    end
  end

  def index
    @pagy, @questions = pagy Question.order(created_at: :desc)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new question_params
    if @question.save
      flash[:success] = "Статья создана!"
      redirect_to questions_path
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question!
    @question = Question.find params[:id]
  end

  
  def authorize_question!
    authorize(@question || Question)
  end
  
end
