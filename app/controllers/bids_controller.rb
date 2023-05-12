class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :not_admin?
  
  def new
    @lot = Lot.find(params[:lot_id])
    @bid = Bid.new()
  end

  def create
    bid_params = params.require(:bid).permit(:value)
    @lot = Lot.find(params[:lot_id])
    @bid = Bid.new(value: bid_params[:value], lot: @lot, user: current_user)
    if @lot.start_date > Date.today || @lot.end_date < Date.today || !@bid.valid?
      flash.now[:notice] = 'Não foi possível fazer o lance'
      render 'new'
    elsif @lot.bids.empty? && @lot.minimum_value >= @bid.value
      flash.now[:notice] = 'Lance deve ser maior que o valor mínimo'
      render 'new'
    elsif !@lot.bids.empty? && @lot.bids.last.value + @lot.minimal_difference > @bid.value
      flash.now[:notice] = 'Lance deve ser maior que o último lance mais a diferença mínima'
      render 'new'
    else
      @bid.save()
      redirect_to auction_path(@lot.id), notice: 'Lance feito com sucesso'
    end
  end
end