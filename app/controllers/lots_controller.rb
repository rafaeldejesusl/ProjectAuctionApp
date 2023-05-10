class LotsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?

  def index
    @lots = Lot.all
  end

  def show
    @lot = Lot.find(params[:id])
  end
end