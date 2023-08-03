class Bid < ApplicationRecord
  belongs_to :lot
  belongs_to :user
  validates :value, presence: true
  validate :value_is_permitted
  validate :lot_permit_bid
  validate :is_user

  private

  def value_is_permitted
    return if !self.value || !self.lot_id
    lot = Lot.find(self.lot.id)
    if lot.bids.empty? && lot.minimum_value >= self.value
      self.errors.add(:value, ' deve ser maior que o valor mínimo')
    elsif !lot.bids.empty? && lot.bids.last.value + lot.minimal_difference > self.value
      self.errors.add(:value, ' deve ser maior que o último lance mais a diferença mínima')
    end
  end

  def lot_permit_bid
    return if !self.lot_id
    lot = Lot.find(self.lot.id)
    if lot.start_date > Date.today || lot.end_date < Date.today
      self.errors.add(:lot_id, ' deve estar em andamento')
    elsif !lot.approved?
      self.errors.add(:lot_id, ' deve estar aprovado')
    end
  end

  def is_user
    return if !self.user
    errors.add(:user, 'não pode ser administrador.') if user.admin?
  end
end
