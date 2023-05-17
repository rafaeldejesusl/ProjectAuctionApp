require 'rails_helper'

describe 'Usuário cadastra um lance' do
	it 'quando estiver logado' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
		end

		# Act
		visit root_path
    click_on 'abc987654'
		expect(page).to have_content "Fazer um Lance"
		click_on 'Fazer um Lance'

		# Assert
		expect(current_path).to eq new_user_session_path
	end

  it 'a partir da tela do leilão' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
		end

		# Act
    login_as user
		visit root_path
    click_on 'abc987654'
		click_on 'Fazer um Lance'

		# Assert
		expect(page).to have_content 'Novo Lance'
    expect(page).to have_field 'Valor'
    expect(page).to have_button 'Dar Lance'
	end

  it 'quando lote estiver em andamento' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 2.week.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
		end

		# Act
    login_as user
		visit root_path
    click_on 'abc987654'

		# Assert
		expect(page).not_to have_link 'Fazer um Lance'
	end

  it 'quando for maior que o valor mínimo' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
		end

		# Act
    login_as user
		visit root_path
    click_on 'abc987654'
    click_on 'Fazer um Lance'
    fill_in 'Valor', with: 10
    click_on 'Dar Lance'

		# Assert
		expect(page).to have_content 'Lance deve ser maior que o valor mínimo'
	end

  it 'quando for maior que a diferença mínima' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
		end
    Bid.create!(value: 11, user: user, lot: lot)

		# Act
    login_as user
		visit root_path
    click_on 'abc987654'
    click_on 'Fazer um Lance'
    fill_in 'Valor', with: 15
    click_on 'Dar Lance'

		# Assert
		expect(page).to have_content 'Lance deve ser maior que o último lance mais a diferença mínima'
	end

  it 'com sucesso' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
		end
    Bid.create!(value: 11, user: user, lot: lot)

		# Act
    login_as user
		visit root_path
    click_on 'abc987654'
    click_on 'Fazer um Lance'
    fill_in 'Valor', with: 16
    click_on 'Dar Lance'

		# Assert
		expect(page).to have_content 'Lance feito com sucesso'
    expect(page).to have_content 'Último Lance: 16 R$'
	end

  it 'com dados incompletos' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
		end
    Bid.create!(value: 11, user: user, lot: lot)

		# Act
    login_as user
		visit root_path
    click_on 'abc987654'
    click_on 'Fazer um Lance'
    fill_in 'Valor', with: ''
    click_on 'Dar Lance'

		# Assert
		expect(page).to have_content 'Não foi possível fazer o lance'
	end
end