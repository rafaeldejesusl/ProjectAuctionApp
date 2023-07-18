class Lot < ApplicationRecord
  has_many :items
  has_many :bids
  has_many :questions
  belongs_to :created_by, class_name: 'User'
  belongs_to :approved_by, class_name: 'User', optional: true
  validates :code, :start_date, :end_date, :minimum_value, :minimal_difference, presence: true
  validates :code, uniqueness: true
  validates :code, format: { with: /\A\w{3}\d{6}\z/ }
  validates :end_date, comparison: { greater_than: :start_date }
  validate :start_date_is_future, on: :create
  validate :approved_by_different_user

  enum status: { pending: 0, approved: 5, closed: 10, cancelled: 15 }

  def is_favorite?(user_id)
    favorite = Favorite.where(user_id: user_id, lot_id: self.id)
    !favorite.empty?
  end

  private

  def start_date_is_future
    if self.start_date.present? && self.start_date <= Date.today
      self.errors.add(:start_date, ' deve ser futura.')
    end
  end

  def approved_by_different_user
    if self.approved_by == self.created_by
      self.errors.add(:approved_by, ' deve ser diferente do criador.')
    end
  end
end
