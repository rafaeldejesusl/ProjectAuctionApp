class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?

	def index
    @items = Item.all
	end

  def show
    @item = Item.find(params[:id])
  end
end