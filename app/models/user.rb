class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :cpf, presence: true
  validates :cpf, uniqueness: true
  validates :cpf, length: { is: 11 }
  validate :validate_cpf
  validate :check_blocked_cpf

  before_validation :check_admin

  def active_for_authentication?
    super && cpf_is_not_blocked?
  end

  def inactive_message
    cpf_is_not_blocked? ? super : :locked
  end  

  private

  def check_admin
    self.admin = self.email.end_with?("@leilaodogalpao.com.br")
  end

  def validate_cpf
    errors.add(:cpf, "não é válido") unless CPF.valid?(cpf)
  end

  def check_blocked_cpf
    blocked_list = BlockedCpf.all
    check = blocked_list.filter {|b| b.cpf == cpf}
    errors.add(:cpf, "está bloqueado") unless check.empty?
  end

  def cpf_is_not_blocked?
    blocked = BlockedCpf.where(cpf: self.cpf)
    blocked.empty?
  end
end
