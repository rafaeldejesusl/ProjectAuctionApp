class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :lot
  validate :not_repeat

  private

  def not_repeat
    favorite = Favorite.where(lot_id: self.lot_id, user_id: self.user_id)
    if !favorite.empty?
      self.errors.add(:lot_id, 'não pode ser repetido.')
    end
  end
end
