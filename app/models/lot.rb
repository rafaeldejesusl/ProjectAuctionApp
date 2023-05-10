class Lot < ApplicationRecord
  belongs_to :created_by, class_name: 'User'
  belongs_to :approved_by, class_name: 'User', optional: true
  validates :code, :start_date, :end_date, :minimum_value, :minimal_difference, presence: true
  validates :code, uniqueness: true
  validates :code, format: { with: /\A\w{3}\d{6}\z/ }
  validates :end_date, comparison: { greater_than: :start_date }
  validate :start_date_is_future

  enum status: { pending: 0, approved: 5 }

  private

  def start_date_is_future
    if self.start_date.present? && self.start_date <= Date.today
      self.errors.add(:start_date, ' deve ser futura.')
    end
  end
end
