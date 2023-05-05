class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :cpf, presence: true
  validates :cpf, uniqueness: true
  validates :cpf, length: { is: 11 }
  validate :validate_cpf

  before_validation :check_admin

  private

  def check_admin
    self.admin = self.email.end_with?("@leilaodogalpao.com.br")
  end

  def validate_cpf
    errors.add(:cpf, "não é válido") unless CPF.valid?(cpf)
  end
end
