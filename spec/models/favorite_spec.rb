require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe '#valid?' do
		it 'falso quando usuário e lote forem repetidos' do
			# Arrange
			user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
        cpf: CPF.generate)
      lot = Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: user)
			Favorite.create!(user: user, lot: lot)
      favorite = Favorite.new(user: user, lot: lot)
      
			# Act
			result = favorite.valid?

			# Assert
			expect(result).to eq false
		end

		it 'falso quando o usuário é administrador' do
			# Arrange
			user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
        cpf: CPF.generate)
      lot = Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: user)
      favorite = Favorite.new(user: user, lot: lot)
      
			# Act
			result = favorite.valid?

			# Assert
			expect(result).to eq false
		end
  end
end
