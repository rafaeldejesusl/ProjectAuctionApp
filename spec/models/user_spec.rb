require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
		it 'falso quando o nome é vazio' do
			# Arrange
			user = User.new(name: '', email: 'joao@email.com', password: 'password',
        cpf: CPF.generate)

			# Act
			result = user.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o cpf é vazio' do
			# Arrange
			user = User.new(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: '')

			# Act
			result = user.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o cpf tem comprimento inválido' do
			# Arrange
      cpf = CPF.generate formatted: true
			user = User.new(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: cpf)

			# Act
			result = user.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o cpf é repetido' do
			# Arrange
      cpf = CPF.generate
			User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: cpf)
      user = User.new(name: 'Ana', email: 'ana@leilaodogalpao.com.br', password: 'password',
        cpf: cpf)

			# Act
			result = user.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o cpf é inválido' do
			# Arrange
			user = User.new(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: '03993920385')

			# Act
			result = user.valid?

			# Assert
			expect(result).to eq false
		end

		it 'falso quando o cpf é bloqueado' do
			# Arrange
			user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
				cpf: CPF.generate)
			cpf = CPF.generate
			blocked_cpf = BlockedCpf.create!(cpf: cpf, reason: "Não pagamento", blocked_by: user)
			new_user = User.new(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: cpf)

			# Act
			result = new_user.valid?

			# Assert
			expect(result).to eq false
		end
	end

  describe '#admin' do
    it 'verdadeiro quando email terminar em "@leilaodogalpao.com.br"' do
			# Arrange
			user = User.new(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
        cpf: CPF.generate)

			# Act
			user.valid?

			# Assert
			expect(user.admin).to eq true
		end

    it 'falso quando email não terminar em "@leilaodogalpao.com.br"' do
			# Arrange
			user = User.new(name: 'Joao', email: 'joao@leilao.com.br', password: 'password',
        cpf: CPF.generate)

			# Act
			user.valid?

			# Assert
			expect(user.admin).to eq false
		end
  end
end
