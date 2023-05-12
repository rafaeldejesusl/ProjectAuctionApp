class AuctionsController < ApplicationController
  before_action :not_admin?
  before_action :authenticate_user!, only: [:won]

  def show
    @lot = Lot.find(params[:id])
  end

  def won
    @lots = Lot.where('status = 10')
    @lots = @lots.select {|l| l.bids.last.id == current_user.id}
  end
end