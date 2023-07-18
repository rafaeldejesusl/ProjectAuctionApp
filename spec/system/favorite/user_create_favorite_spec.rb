require 'rails_helper'

describe 'Usuário cria um novo lote favorito' do
  it 'quando estiver logado' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 2.week.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
		end
		
		# Act
		visit('/')
    click_on 'abc987654'
		
		# Assert
		expect(page).to have_content('abc987654')
    expect(page).not_to have_button('Marcar como Favorito')
	end

  it 'a partir da página de leilões' do
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
		visit('/')
    click_on 'abc987654'
		
		# Assert
		expect(page).to have_content('abc987654')
    expect(page).to have_button('Marcar como Favorito')
	end

  it 'e marcar um lote como favorito' do
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
		visit('/')
    click_on 'abc987654'
    click_on 'Marcar como Favorito'
		
		# Assert
		expect(page).to have_content('Lote salvo como favorito')
    expect(page).not_to have_button('Marcar como Favorito')
	end
end