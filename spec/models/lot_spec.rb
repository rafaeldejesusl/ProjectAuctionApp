require 'rails_helper'

RSpec.describe Lot, type: :model do
  describe '#valid?' do
		it 'falso quando o código é vazio' do
			# Arrange
      user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: CPF.generate)
			lot = Lot.new(code: '', start_date: 1.day.from_now, end_date: 1.week.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: user)

			# Act
			result = lot.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando a data de início é vazia' do
			# Arrange
      user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: CPF.generate)
			lot = Lot.new(code: 'abc123456', start_date: '', end_date: 1.week.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: user)

			# Act
			result = lot.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando a data limite é vazia' do
			# Arrange
      user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: CPF.generate)
			lot = Lot.new(code: 'abc123456', start_date: 1.day.from_now, end_date: '',
        minimum_value: 10, minimal_difference: 5, created_by: user)

			# Act
			result = lot.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o valor mínimo é vazio' do
			# Arrange
      user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: CPF.generate)
			lot = Lot.new(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
        minimum_value: '', minimal_difference: 5, created_by: user)

			# Act
			result = lot.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando a diferença mínima é vazia' do
			# Arrange
      user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: CPF.generate)
			lot = Lot.new(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
        minimum_value: 10, minimal_difference: '', created_by: user)

			# Act
			result = lot.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o "criado por" é vazio' do
			# Arrange
			lot = Lot.new(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
        minimum_value: 10, minimal_difference: 5)

			# Act
			result = lot.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o código é repetido' do
			# Arrange
      user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: CPF.generate)
      Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: user)
			lot = Lot.new(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: user)

			# Act
			result = lot.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o código é inválido' do
			# Arrange
      user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: CPF.generate)
			lot = Lot.new(code: 'ab123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: user)

			# Act
			result = lot.valid?

			# Assert
			expect(result).to eq false
		end

    it 'data de início não deve ser passada' do
			# Arrange
			lot = Lot.new(start_date: 1.day.ago)

			# Act
			lot.valid?
      result = lot.errors.include?(:start_date)

			# Assert
			expect(result).to eq true
      expect(lot.errors[:start_date]).to include ' deve ser futura.'
		end

    it 'data de início não deve ser hoje' do
			# Arrange
			lot = Lot.new(start_date: Date.today)

			# Act
			lot.valid?
      result = lot.errors.include?(:start_date)

			# Assert
			expect(result).to eq true
      expect(lot.errors[:start_date]).to include ' deve ser futura.'
		end

    it 'data de início deve ser igual ou maior que amanhã' do
			# Arrange
			lot = Lot.new(start_date: 1.day.from_now)

			# Act
			lot.valid?

			# Assert
      expect(lot.errors.include?(:start_date)).to eq false
		end

    it 'data limite deve ser maior que data de início' do
			# Arrange
			lot = Lot.new(start_date: 1.day.from_now, end_date: 1.day.from_now)

			# Act
			lot.valid?
      result = lot.errors.include?(:end_date)

			# Assert
			expect(result).to eq true
		end
  end
end
