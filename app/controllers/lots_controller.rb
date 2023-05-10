class LotsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?

  def index
    @lots = Lot.all
  end

  def show
    @lot = Lot.find(params[:id])
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
end