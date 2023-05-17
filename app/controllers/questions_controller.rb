class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :not_admin?, only: [:new, :create]
  before_action :is_admin?, only: [:hide]

  def new
    @lot = Lot.find(params[:lot_id])
    @question = Question.new()
  end

  def create
    question_params = params.require(:question).permit(:content)
    @lot = Lot.find(params[:lot_id])
    @question = Question.new(content: question_params[:content], lot: @lot, user: current_user)
    if @question.save()
      redirect_to auction_path(@lot.id), notice: "Pergunta feita com sucesso"
    else
      flash.now[:notice] = 'Pergunta não foi criada'
      render 'new'
    end
  end

  def hide
    @question = Question.find(params[:id])
    if @question.update(visible: false)
      redirect_to unanswered_lots_path, notice: 'Pergunta ocultada com sucesso'
    else
      redirect_to unanswered_lots_path, notice: 'Pergunta não foi ocultada'
    end
  end
end