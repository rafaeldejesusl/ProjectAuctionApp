require 'rails_helper'

describe 'Usuário remove um lote dos favoritos' do
  it 'a partir da página de leilões' do
    # Arrange
		user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 2.week.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
		end
    Favorite.create!(user: user, lot: lot)
		
		# Act
		login_as user
		visit('/')
    click_on 'abc987654'
		
		# Assert
		expect(page).to have_content('abc987654')
    expect(page).to have_button('Desmarcar Favorito')
  end
  
    it 'e desmarcar um lote como favorito' do
      # Arrange
      user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
        cpf: CPF.generate)
      lot = nil
      travel_to 1.week.ago do
        lot = Lot.create!(code: 'abc987654', start_date: 2.week.from_now, end_date: 3.week.from_now,
          minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
      end
      Favorite.create!(user: user, lot: lot)
      
      # Act
      login_as user
      visit('/')
      click_on 'Favoritos'
      click_on 'Desmarcar Favorito'
      
      # Assert
      expect(page).not_to have_content('abc987654')
    end

  it 'a partir da página de lotes favoritos' do
    # Arrange
		user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 2.week.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
      end
    Favorite.create!(user: user, lot: lot)
		
		# Act
		login_as user
		visit('/')
    click_on 'Favoritos'
		
		# Assert
		expect(page).to have_content('abc987654')
    expect(page).to have_button('Desmarcar Favorito')
  end

  it 'e desmarcar um lote como favorito' do
    # Arrange
		user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 2.week.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
		end
    Favorite.create!(user: user, lot: lot)
		
		# Act
		login_as user
		visit('/')
    click_on 'abc987654'
    click_on 'Desmarcar Favorito'
		
		# Assert
		expect(page).not_to have_content('Desmarcar Favorito')
    expect(page).to have_content('Marcar como Favorito')
  end
end