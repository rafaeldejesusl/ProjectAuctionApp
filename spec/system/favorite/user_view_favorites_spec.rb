require 'rails_helper'

describe 'Usuário acessa página de lotes favoritos' do
  it 'a partir da tela inicial' do
    # Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    
    # Act
    login_as user
    visit('/')
    
    # Assert
    expect(page).to have_content('Favoritos')
  end

  it 'quando estiver logado' do
		# Arrange
		
		# Act
		visit('/')
    click_on 'Favoritos'
		
		# Assert
		expect(current_path).to eq new_user_session_path
	end

  it 'e visualiza os favoritos' do
		# Arrange
		admin = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
			cpf: CPF.generate)
		user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 2.week.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
		end
    Favorite.create!(user: user, lot: lot)
		
		# Act
		login_as user
		visit('/')
    click_on 'Favoritos'
		
		# Assert
		expect(page).to have_content('Lotes Favoritos')
    expect(page).to have_content('abc987654')
	end

  it 'quando a lista estiver vazia' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
		
		# Act
		login_as user
		visit('/')
    click_on 'Favoritos'
		
		# Assert
		expect(page).to have_content('Lotes Favoritos')
    expect(page).to have_content('Lista de favoritos vazia')
	end
end