require 'rails_helper'

describe 'Usuário busca por um leilão' do
	it 'a partir da tela inicial' do
		# Arrange

		# Act
		visit root_path

		# Assert
    expect(page).to have_field 'Buscar Leilões'
    expect(page).to have_button 'Buscar'
	end

  it 'e encontra um leilão' do
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
		fill_in 'Buscar Leilões', with: 'abc987654'
		click_on 'Buscar'

		# Assert
		expect(page).to have_content 'Resultados da Busca por: abc987654'
		expect(page).to have_content '1 leilão encontrado'
		expect(page).to have_content 'abc987654'
	end

  it 'e encontra múltiplos leilões' do
		# Arrange
		admin = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
			cpf: CPF.generate)
		user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
		travel_to 1.week.ago do
			Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
      Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 3.week.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
      Lot.create!(code: 'xyz987654', start_date: 1.day.from_now, end_date: 3.week.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
		end

		# Act
		login_as user
		visit root_path
		fill_in 'Buscar Leilões', with: 'abc'
		click_on 'Buscar'

		# Assert
		expect(page).to have_content 'Resultados da Busca por: abc'
		expect(page).to have_content '2 leilões encontrados'
		expect(page).to have_content 'abc987654'
    expect(page).to have_content 'abc123456'
    expect(page).not_to have_content 'xyz987654'
	end

  it 'através do item do leilão' do
		# Arrange
		admin = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
			cpf: CPF.generate)
		user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
    other_lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
      other_lot = Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 3.week.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
		end
    Item.create!(name: 'Tablet', description: 'Tablet 10" da Samsung', image_url: '',
      weight: 320, width: 15, height: 25, depth: 1, category: 'Eletrônico', lot: lot)
    Item.create!(name: 'Cadeira', description: 'Cadeira gamer', image_url: '',
      weight: 1200, width: 50, height: 85, depth: 50, category: 'Mobília', lot: other_lot)

		# Act
		login_as user
		visit root_path
		fill_in 'Buscar Leilões', with: 'tab'
		click_on 'Buscar'

		# Assert
		expect(page).to have_content 'Resultados da Busca por: tab'
		expect(page).to have_content '1 leilão encontrado'
		expect(page).to have_content 'abc987654'
    expect(page).not_to have_content 'abc123456'
	end
end