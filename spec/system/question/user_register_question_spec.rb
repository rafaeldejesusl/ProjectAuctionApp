require 'rails_helper'

describe 'Usuário cria uma pergunta' do
  it 'a partir da tela de leilão' do
		# Arrange
		admin = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
			cpf: CPF.generate)
		user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
		travel_to 1.week.ago do
			Lot.create!(code: 'abc987654', start_date: 2.week.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
		end
		
		# Act
		login_as user
		visit('/')
    click_on 'abc987654'
    click_on 'Fazer uma Pergunta'
		
		# Assert
		expect(page).to have_field('Dúvida')
	end

  it 'com sucesso' do
		# Arrange
		admin = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
			cpf: CPF.generate)
		user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
		travel_to 1.week.ago do
			Lot.create!(code: 'abc987654', start_date: 2.week.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
		end
		
		# Act
		login_as user
		visit('/')
    click_on 'abc987654'
    click_on 'Fazer uma Pergunta'
    fill_in 'Dúvida', with: 'Quanto é?'
    click_on 'Fazer Pergunta'
		
		# Assert
		expect(page).to have_content('Quanto é?')
	end

  it 'com dados incompletos' do
		# Arrange
		admin = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
			cpf: CPF.generate)
		user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
		travel_to 1.week.ago do
			Lot.create!(code: 'abc987654', start_date: 2.week.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
		end
		
		# Act
		login_as user
		visit('/')
    click_on 'abc987654'
    click_on 'Fazer uma Pergunta'
    fill_in 'Dúvida', with: ''
    click_on 'Fazer Pergunta'
		
		# Assert
		expect(page).to have_content('Pergunta não foi criada')
	end
end