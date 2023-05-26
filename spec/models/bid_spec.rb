require 'rails_helper'

RSpec.describe Bid, type: :model do
  describe '#valid?' do
		it 'falso quando o valor é vazio' do
			# Arrange
			user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: CPF.generate)
			lot = nil
			travel_to 5.day.ago do
				lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 1.week.from_now,
					minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
			end
      bid = Bid.new(value: '', lot: lot, user: user)
      
			# Act
			result = bid.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o lote é vazio' do
			# Arrange
			user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: CPF.generate)
      bid = Bid.new(value: 50, user: user)
      
			# Act
			result = bid.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o usuário é vazio' do
			# Arrange
			user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: CPF.generate)
			lot = nil
			travel_to 5.day.ago do
				lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 1.week.from_now,
					minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
			end
      bid = Bid.new(value: 50, lot: lot)
      
			# Act
			result = bid.valid?

			# Assert
			expect(result).to eq false
		end

		it 'falso quando o lance inicial é menor ou igual que o valor mínimo' do
			# Arrange
			user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: CPF.generate)
			lot = nil
			travel_to 5.day.ago do
				lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 1.week.from_now,
					minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
			end
      bid = Bid.new(value: 10, lot: lot, user: user)
      
			# Act
			result = bid.valid?

			# Assert
			expect(result).to eq false
		end

		it 'falso quando o lance não inicial é menor que o último lance mais a diferença mínima' do
			# Arrange
			user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: CPF.generate)
			lot = nil
			travel_to 5.day.ago do
				lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 1.week.from_now,
					minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
			end
			Bid.create!(value: 20, lot: lot, user: user)
      bid = Bid.new(value: 24, lot: lot, user: user)
      
			# Act
			result = bid.valid?

			# Assert
			expect(result).to eq false
		end

		it 'falso quando o lote não iniciou' do
			# Arrange
			user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: CPF.generate)
      lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 1.week.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
      bid = Bid.new(value: 25, lot: lot, user: user)
      
			# Act
			result = bid.valid?

			# Assert
			expect(result).to eq false
		end

		it 'falso quando o lote não iniciou' do
			# Arrange
			user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: CPF.generate)
			lot = nil
			travel_to 5.day.ago do
				lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 3.day.from_now,
					minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
			end
      bid = Bid.new(value: 25, lot: lot, user: user)
      
			# Act
			result = bid.valid?

			# Assert
			expect(result).to eq false
		end

		it 'falso quando o lote não foi aprovado' do
			# Arrange
			user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: CPF.generate)
			lot = nil
			travel_to 5.day.ago do
				lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 1.week.from_now,
					minimum_value: 10, minimal_difference: 5, created_by: user, status: :pending)
			end
      bid = Bid.new(value: 50, lot: lot, user: user)
      
			# Act
			result = bid.valid?

			# Assert
			expect(result).to eq false
		end
  end
end
