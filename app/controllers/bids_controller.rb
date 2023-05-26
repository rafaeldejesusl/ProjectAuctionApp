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

    if @bid.valid?
      @bid.save()
      redirect_to auction_path(@lot.id), notice: 'Lance feito com sucesso'
    else
      flash.now[:notice] = 'Não foi possível fazer o lance'
      render 'new'
    end
  end
end