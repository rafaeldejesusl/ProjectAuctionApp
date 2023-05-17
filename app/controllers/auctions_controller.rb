class AuctionsController < ApplicationController
  before_action :not_admin?
  before_action :authenticate_user!, only: [:won]

  def show
    @lot = Lot.find(params[:id])
    @questions = Question.where(lot_id: @lot.id, visible: true)
  end

  def won
    @lots = Lot.where('status = 10')
    @lots = @lots.select {|l| l.bids.last.id == current_user.id}
  end

  def search
    @text = params['query']
    auctions_by_item = Lot.includes(:items).where("items.name LIKE ? AND status = 5 AND end_date >= ?", "%#{@text}%", Date.today).references(:items)
    auctions_by_code = Lot.where("code LIKE ? AND status = 5 AND end_date >= ?", "%#{@text}%", Date.today)
    @auctions = auctions_by_code + auctions_by_item
  end
end