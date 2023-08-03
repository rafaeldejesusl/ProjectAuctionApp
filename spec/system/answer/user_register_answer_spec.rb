require 'rails_helper'

describe 'Usuário registra uma resposta' do
  it 'a partir da tela de perguntas' do
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
    click_on 'Responder'
		
		# Assert
    expect(page).to have_field('Resposta')
	end

  it 'com sucesso' do
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
    click_on 'Responder'
    fill_in 'Resposta', with: '20 conto'
    click_on 'Responder Pergunta'
		
		# Assert
    expect(current_path).to eq unanswered_lots_path
    expect(page).to have_content('Resposta feita com sucesso')
    expect(page).not_to have_content('Quanto é?')
	end

  it 'com dados incompletos' do
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
    click_on 'Responder'
    fill_in 'Resposta', with: ''
    click_on 'Responder Pergunta'
		
		# Assert
    expect(page).to have_content('Resposta não foi criada')
	end
end