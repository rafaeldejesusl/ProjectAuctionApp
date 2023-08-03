class Question < ApplicationRecord
  belongs_to :user
  belongs_to :lot
  has_one :answer
  validates :content, presence: true
  validate :is_user

  private

  def is_user
    return if !self.user
    errors.add(:user, 'não pode ser administrador.') if user.admin?
  end
end
