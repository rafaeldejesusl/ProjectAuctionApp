require 'rails_helper'

describe 'Usuário cadastra um lance' do
	it 'quando estiver logado' do
		# Arrange
		admin = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
			cpf: CPF.generate)
    user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
		travel_to 1.week.ago do
			Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
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
		admin = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
			cpf: CPF.generate)
    user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
		travel_to 1.week.ago do
			Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
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
		visit root_path
    click_on 'abc987654'

		# Assert
		expect(page).not_to have_link 'Fazer um Lance'
	end

  it 'quando lance inicial for maior que o valor mínimo' do
		# Arrange
		admin = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
			cpf: CPF.generate)
    user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
		travel_to 1.week.ago do
			Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
		end

		# Act
    login_as user
		visit root_path
    click_on 'abc987654'
    click_on 'Fazer um Lance'
    fill_in 'Valor', with: 10
    click_on 'Dar Lance'

		# Assert
		expect(page).to have_content 'Não foi possível fazer o lance'
	end

  it 'quando lance não inicial for maior que último lance mais diferença mínima' do
		# Arrange
		admin = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
			cpf: CPF.generate)
    user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
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
		expect(page).to have_content 'Não foi possível fazer o lance'
	end

  it 'com sucesso' do
		# Arrange
		admin = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
			cpf: CPF.generate)
    user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
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
		admin = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
			cpf: CPF.generate)
    user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
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