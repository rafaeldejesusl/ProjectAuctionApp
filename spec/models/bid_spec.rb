require 'rails_helper'

RSpec.describe Bid, type: :model do
  describe '#valid?' do
		it 'falso quando o valor é vazio' do
			# Arrange
			user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: CPF.generate)
      lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 1.week.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: user)
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
      lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 1.week.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: user)
      bid = Bid.new(value: 50, lot: lot)
      
			# Act
			result = bid.valid?

			# Assert
			expect(result).to eq false
		end
  end
end
