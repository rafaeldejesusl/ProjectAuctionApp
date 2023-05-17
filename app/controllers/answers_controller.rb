class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?

  def new
    @lot = Lot.find(params[:lot_id])
    @question = Question.find(params[:question_id])
    @answer = Answer.new()
  end

  def create
    answer_params = params.require(:answer).permit(:content)
    @question = Question.find(params[:question_id])
    @answer = Answer.new(content: answer_params[:content], question: @question, user: current_user)
    if @answer.save()
      redirect_to unanswered_lots_path, notice: "Resposta feita com sucesso"
    else
      redirect_to new_lot_question_answer_path(@question.lot.id, @question.id), notice: "Resposta não foi criada"
    end
  end
end