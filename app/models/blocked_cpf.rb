class BlockedCpf < ApplicationRecord
  belongs_to :blocked_by, class_name: 'User'
  validates :cpf, :reason, presence: true
  validates :cpf, length: { is: 11 }
  validates :cpf, uniqueness: true
  validate :validate_cpf
  validate :blocked_by_admin

  private

  def validate_cpf
    errors.add(:cpf, "não é válido") unless CPF.valid?(cpf)
  end

  def blocked_by_admin
    return if !self.blocked_by
    errors.add(:blocked_by, "não tem permissão") unless blocked_by.admin?
  end
end
