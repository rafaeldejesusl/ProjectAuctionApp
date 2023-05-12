require 'rails_helper' # Importação das configurações de test

describe 'Usuário visita tela inicial' do
	it 'quando for não for administrador' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
		
		# Act
		login_as user
		visit('/')
		
		# Assert
		expect(current_path).to eq lots_path
		expect(page).to have_content('Não possui autorização')
	end

	it 'quando for visitante' do
		# Arrange
		
		# Act
		visit('/')
		
		# Assert
		expect(current_path).to eq root_path
		expect(page).to have_content('Lotes em Andamento')
		expect(page).to have_content('Lotes Futuros')
	end

	it 'quando for usuário' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
		
		# Act
		login_as user
		visit('/')
		
		# Assert
		expect(current_path).to eq root_path
		expect(page).to have_content('Lotes em Andamento')
		expect(page).to have_content('Lotes Futuros')
	end

	it 'e vê lotes em andamento' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
		travel_to 1.week.ago do
			Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user)
			Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
		end
		
		# Act
		login_as user
		visit('/')
		
		# Assert
		expect(page).to have_content('Lotes em Andamento')
		expect(page).not_to have_content('abc123456')
		expect(page).to have_content('abc987654')
	end

	it 'e vê lotes futuros' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
		travel_to 1.week.ago do
			Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 5.day.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
			Lot.create!(code: 'abc987654', start_date: 2.week.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
		end
		
		# Act
		login_as user
		visit('/')
		
		# Assert
		expect(page).to have_content('Lotes Futuros')
		expect(page).not_to have_content('abc123456')
		expect(page).to have_content('abc987654')
	end
end