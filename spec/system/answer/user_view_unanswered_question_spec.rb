require 'rails_helper'

describe 'Usuário visualiza as perguntas sem resposta' do
  it 'quando for administrador' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 2.week.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
		end
    Question.create!(content: "Quanto é?", user: user, lot: lot)
		
		# Act
		login_as user
		visit('/')
		
		# Assert
    expect(current_path).to eq root_path
    expect(page).not_to have_content 'Perguntas'
	end

  it 'com sucesso' do
		# Arrange
		admin = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
		user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
			cpf: CPF.generate)
    lot = nil
    other_lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 2.week.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
      other_lot = Lot.create!(code: 'abc123456', start_date: 2.week.from_now, end_date: 3.week.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
		end
    Question.create!(content: "Quanto é?", user: user, lot: lot)
    other_question = Question.create!(content: "Ser ou não ser?", user: user, lot: other_lot)
    Answer.create!(content: "2 conto", user: admin, question: other_question)
		
		# Act
		login_as admin
		visit('/')
    click_on 'Perguntas'
		
		# Assert
    expect(page).to have_content 'abc987654'
    expect(page).to have_content 'Quanto é?'
    expect(page).not_to have_content 'abc123456'
	end

  it 'quando não existem perguntas' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
		travel_to 1.week.ago do
			Lot.create!(code: 'abc987654', start_date: 2.week.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
		end
		
		# Act
		login_as user
		visit('/')
    click_on 'Perguntas'
		
		# Assert
    expect(page).to have_content 'Não existem perguntas'
    expect(page).not_to have_content 'abc987654'
	end

	it 'e oculta uma pergunta' do
		# Arrange
		admin = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
		user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
			cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 2.week.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
		end
    Question.create!(content: "Quanto é?", user: user, lot: lot)
		
		# Act
		login_as admin
		visit('/')
    click_on 'Perguntas'
		click_on 'Ocultar'
		
		# Assert
		expect(page).to have_content 'Pergunta ocultada com sucesso'
    expect(page).not_to have_content 'Quanto é?'
	end
end