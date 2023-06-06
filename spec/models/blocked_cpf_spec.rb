require 'rails_helper'

RSpec.describe BlockedCpf, type: :model do
  describe '#valid?' do
		it 'falso quando o CPF é vazio' do
			# Arrange
			user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
        cpf: CPF.generate)
			blocked_cpf = BlockedCpf.new(cpf: '', blocked_by: user, reason: 'Não pagamento')
      
			# Act
			result = blocked_cpf.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o cpf tem comprimento inválido' do
			# Arrange
      cpf = CPF.generate formatted: true
			user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
        cpf: CPF.generate)
      blocked_cpf = BlockedCpf.new(cpf: cpf, blocked_by: user, reason: 'Não pagamento')

			# Act
			result = blocked_cpf.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o cpf é repetido' do
			# Arrange
      cpf = CPF.generate
			user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
        cpf: CPF.generate)
      BlockedCpf.create!(cpf: cpf, blocked_by: user, reason: 'Não pagamento')
      blocked_cpf = BlockedCpf.new(cpf: cpf, blocked_by: user, reason: 'Não pagamento')

			# Act
			result = blocked_cpf.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o cpf é inválido' do
			# Arrange
			user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
        cpf: CPF.generate)
      blocked_cpf = BlockedCpf.new(cpf: '03993920385', blocked_by: user, reason: 'Não pagamento')

			# Act
			result = blocked_cpf.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o "Bloqueado por" é vazio' do
			# Arrange
			blocked_cpf = BlockedCpf.new(cpf: CPF.generate, reason: 'Não pagamento')
      
			# Act
			result = blocked_cpf.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando for bloqueado por usuário comum' do
			# Arrange
			user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: CPF.generate)
			blocked_cpf = BlockedCpf.new(cpf: CPF.generate, blocked_by: user, reason: 'Não pagamento')
      
			# Act
			result = blocked_cpf.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o motivo é vazio' do
			# Arrange
			user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
        cpf: CPF.generate)
			blocked_cpf = BlockedCpf.new(cpf: CPF.generate, blocked_by: user, reason: '')
      
			# Act
			result = blocked_cpf.valid?

			# Assert
			expect(result).to eq false
		end
  end
end
