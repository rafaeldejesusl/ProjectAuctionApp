class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?

	def index
    @items = Item.all
	end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new()
  end

  def create
    item_params = params.require(:item).permit(:name, :image_url, :category,
      :description, :weight, :width, :height, :depth)
    @item = Item.new(item_params)
    if @item.save()
      redirect_to items_path, notice: 'Item cadastrado com sucesso'
    else
      flash.now[:notice] = 'Item não cadastrado'
      render 'new'	
    end
  end
end