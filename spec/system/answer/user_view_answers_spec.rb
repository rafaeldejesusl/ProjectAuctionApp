require 'rails_helper'

describe 'Usuário visualiza as respostas' do
  it 'na tela do leilão' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 2.week.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
		end
    question = Question.create!(content: "Quanto é?", user: user, lot: lot)
    answer = Answer.create!(content: "20 conto", user: user, question: question)
		
		# Act
		login_as user
		visit('/')
    click_on 'abc987654'
		
		# Assert
    expect(page).to have_content('Quanto é?')
		expect(page).to have_content('20 conto')
	end

  it 'quando a visibilidade for verdadeira' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 2.week.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
		end
    Question.create!(content: "Quanto é?", user: user, lot: lot)
    question = Question.create!(content: "Ser ou não ser?", user: user, lot: lot, visible: false)
    answer = Answer.create!(content: "20 conto", user: user, question: question)
		
		# Act
		login_as user
		visit('/')
    click_on 'abc987654'
		
		# Assert
    expect(page).not_to have_content('20 conto')
	end
end