class AuctionsController < ApplicationController
  before_action :not_admin?

  def show
    @lot = Lot.find(params[:id])
  end
end