class FavoritesController < ApplicationController
  before_action :not_admin?
  before_action :authenticate_user!

  def index
    @favorites = Favorite.where(user_id: current_user.id)
  end

  def add
    favorite = Favorite.new(lot_id: params[:lot_id], user_id: current_user.id)
    favorite.save
    redirect_to auction_path(params[:lot_id]), notice: 'Lote salvo como favorito'
  end
end