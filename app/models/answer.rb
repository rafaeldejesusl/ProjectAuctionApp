class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  validates :content, presence: true
  validate :is_admin

  private 

  def is_admin
    return if !self.user
    errors.add(:user, 'precisa ser administrador.') unless user.admin?
  end
end
