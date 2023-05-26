class LotsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?

  def index
    @lots = Lot.all
  end

  def show
    @lot = Lot.find(params[:id])
    @items = @lot.items
  end

  def new
    @lot = Lot.new()
  end

  def create
    lot_params = params.require(:lot).permit(:code, :start_date, :end_date,
      :minimum_value, :minimal_difference)
    @lot = Lot.new(lot_params)
    @lot.created_by = current_user
    if @lot.save()
      redirect_to lots_path, notice: 'Lote cadastrado com sucesso'
    else
      flash.now[:notice] = 'Lote não cadastrado'
      render 'new'	
    end
  end

  def new_item
    @lot = Lot.find(params[:id])
    @items = Item.where(lot_id: nil)
  end

  def add_item
    item = Item.find(params[:item_id])
    @lot = Lot.find(params[:id])

    if item.lot_id.nil? && @lot.pending?
      item.lot = @lot
      item.save
      redirect_to lot_path(@lot.id), notice: 'Item adicionado com sucesso'
    else
      redirect_to lot_path(@lot.id), notice: 'Não foi possível adicionar o item'
    end
  end

  def approved
    @lot = Lot.find(params[:id])

    if @lot.pending? && @lot.update(status: :approved, approved_by_id: current_user.id)
      redirect_to lot_path(@lot.id), notice: 'Lote aprovado com sucesso'
    else
      redirect_to lot_path(@lot.id), notice: 'Não foi possível aprovar o lote'
    end
  end

  def finished
    @lots = Lot.where('end_date < ? and status = 5', Date.today)
  end

  def close
    @lot = Lot.find(params[:id])
    if @lot.approved? && !@lot.bids.empty?
      @lot.update(status: :closed)
      redirect_to finished_lots_path , notice: 'Lote encerrado com sucesso'
    else
      redirect_to finished_lots_path, notice: 'Não foi possível encerrar o lote'
    end
  end

  def cancel
    @lot = Lot.find(params[:id])
    if @lot.approved? && @lot.bids.empty?
      @lot.update(status: :cancelled)
      @lot.items.each do |i|
        i.update(lot_id: nil)
      end
      redirect_to finished_lots_path , notice: 'Lote cancelado com sucesso'
    else
      redirect_to finished_lots_path, notice: 'Não foi possível cancelar o lote'
    end
  end

  def unanswered
    @questions = Question.includes(:answer).where(answer: { id: nil}, visible: true)
  end
end