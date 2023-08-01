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

  def destroy
    favorite = Favorite.where(lot_id: params[:lot_id], user_id: current_user.id)
    favorite[0].destroy
    if request.referer.include?('favorites')
      return redirect_to favorites_path(), notice: 'Lote removido dos favoritos'
    end
    redirect_to auction_path(params[:lot_id]), notice: 'Lote removido dos favoritos'
  end
end