require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe '#valid?' do
		it 'falso quando o conteúdo é vazio' do
			# Arrange
      admin = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
        cpf: CPF.generate)
			user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
				cpf: CPF.generate)
      lot = Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: admin)
			question = Question.create!(content: "Quanto é?", user: user, lot: lot)
      answer = Answer.new(content: "", user: admin, question: question)

			# Act
			result = answer.valid?

			# Assert
			expect(result).to eq false
		end

		it 'falso quando o criador não for administrador' do
			# Arrange
			admin = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
        cpf: CPF.generate)
      user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
        cpf: CPF.generate)
      lot = Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: admin)
			question = Question.create!(content: "Quanto é?", user: user, lot: lot)
      answer = Answer.new(content: "15 conto", user: user, question: question)

			# Act
			result = answer.valid?

			# Assert
			expect(result).to eq false
		end
  end
end
