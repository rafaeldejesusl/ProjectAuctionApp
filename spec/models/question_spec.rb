require 'rails_helper'

RSpec.describe Question, type: :model do
  describe '#valid?' do
		it 'falso quando o conteúdo é vazio' do
			# Arrange
      user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: CPF.generate)
      lot = Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: user)
			question = Question.new(content: "", user: user, lot: lot)

			# Act
			result = question.valid?

			# Assert
			expect(result).to eq false
		end
  end

  describe 'tem a visibilidade' do
		it 'como verdadeira quando é criada' do
			# Arrange
      user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: CPF.generate)
      lot = Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: user)
			question = Question.new(content: "Quanto é?", user: user, lot: lot)

			# Act
			question.save!

			# Assert
			expect(question.visible).to eq true
		end
  end
end
