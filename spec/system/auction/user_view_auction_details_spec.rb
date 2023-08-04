require 'rails_helper'

describe 'Usuário visita detalhes de um leilão' do
  it 'a partir da tela inicial' do
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
		
		# Act
		login_as user
		visit('/')
    click_on 'abc987654'
		
		# Assert
		expect(page).to have_content('abc987654')
    expect(page).to have_content("Data de Início: #{I18n.localize(lot.start_date)}")
    expect(page).to have_content("Data Limite: #{I18n.localize(lot.end_date)}")
    expect(page).to have_content('Valor Mínimo: 10 R$')
    expect(page).to have_content('Diferença Mínima: 5 R$')
	end

  it 'e vê itens do leilão' do
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
    Item.create!(name: 'Tablet', description: 'Tablet 10" da Samsung',
      weight: 320, width: 15, height: 25, depth: 1, category: 'Eletrônico')
    allow(SecureRandom).to receive(:alphanumeric).and_return('XYZ9876543')
    Item.create!(name: 'Cadeira', description: 'Cadeira gamer', lot: lot,
      weight: 1200, width: 50, height: 85, depth: 50, category: 'Mobília')
		
		# Act
		login_as user
		visit('/')
    click_on 'abc987654'
		
		# Assert
		expect(page).to have_content('Cadeira')
    expect(page).to have_content('Código: XYZ9876543')
		expect(page).to have_content('Descrição: Cadeira gamer')
		expect(page).to have_content('Peso: 1200 g')
		expect(page).to have_content('Dimensão: 50 cm x 85 cm x 50 cm')
		expect(page).to have_content('Categoria: Mobília')
    expect(page).not_to have_content('Tablet')
	end

	it 'e vê último lance' do
		# Arrange
		admin = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
			cpf: CPF.generate)
		user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 1.week.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
		end
		Bid.create!(value: 30, user: user, lot: lot)
    Bid.create!(value: 50, user: user, lot: lot)
		
		# Act
		login_as user
		visit('/')
    click_on 'abc987654'
		
		# Assert
		expect(page).to have_content('Último Lance: 50 R$')
    expect(page).not_to have_content('30 R$')
	end

	it 'e volta para a tela inicial' do
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
		click_on 'Voltar'
		
		# Assert
		expect(current_path).to eq root_path
	end
end