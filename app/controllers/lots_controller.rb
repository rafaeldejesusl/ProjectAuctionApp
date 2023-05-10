class LotsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?

  def index
    @lots = Lot.all
  end
end