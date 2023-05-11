require 'rails_helper'

describe 'Usuário adiciona um item no lote' do
  it 'quando lote está em andamento' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
    other_user = User.create!(name: 'Ana', email: 'ana@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
    lot_a = Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
      minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved, approved_by: other_user)
    Item.create!(name: 'Tablet', description: 'Tablet 10" da Samsung', image_url: '',
      weight: 320, width: 15, height: 25, depth: 1, category: 'Eletrônico')
    Item.create!(name: 'Cadeira', description: 'Cadeira gamer', image_url: '',
      weight: 1200, width: 50, height: 85, depth: 50, category: 'Mobília')

		# Act
		login_as user
		visit root_path
    click_on 'Lotes'
		click_on 'abc123456'

		# Assert
    expect(page).not_to have_link('Adicionar Item ao Lote')
	end

	it 'a partir da tela de detalhes do lote' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
    lot_a = Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
      minimum_value: 10, minimal_difference: 5, created_by: user)
    Item.create!(name: 'Canivete', description: 'Canivete suíço', image_url: '',
      weight: 120, width: 5, height: 15, depth: 5, category: 'Ferramenta', lot: lot_a)
    Item.create!(name: 'Tablet', description: 'Tablet 10" da Samsung', image_url: '',
      weight: 320, width: 15, height: 25, depth: 1, category: 'Eletrônico')
    Item.create!(name: 'Cadeira', description: 'Cadeira gamer', image_url: '',
      weight: 1200, width: 50, height: 85, depth: 50, category: 'Mobília')

		# Act
		login_as user
		visit root_path
    click_on 'Lotes'
		click_on 'abc123456'
    click_on 'Adicionar Item ao Lote'

		# Assert
		expect(page).to have_select('Item', options: ['Tablet', 'Cadeira'])
    expect(page).to have_button('Confirmar Adição')
	end

  it 'com sucesso' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
    lot_a = Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
      minimum_value: 10, minimal_difference: 5, created_by: user)
    Item.create!(name: 'Tablet', description: 'Tablet 10" da Samsung', image_url: '',
      weight: 320, width: 15, height: 25, depth: 1, category: 'Eletrônico')
    Item.create!(name: 'Cadeira', description: 'Cadeira gamer', image_url: '',
      weight: 1200, width: 50, height: 85, depth: 50, category: 'Mobília')

		# Act
		login_as user
		visit root_path
    click_on 'Lotes'
		click_on 'abc123456'
    click_on 'Adicionar Item ao Lote'
    select 'Cadeira', from: 'Item'
    click_on 'Confirmar Adição'

		# Assert
		expect(current_path).to eq lot_path(lot_a.id)
    expect(page).to have_content('Cadeira')
    expect(page).to have_content('Item adicionado com sucesso')
	end

  it 'com itens indisponíveis' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
    lot_a = Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
      minimum_value: 10, minimal_difference: 5, created_by: user)

		# Act
		login_as user
		visit root_path
    click_on 'Lotes'
		click_on 'abc123456'
    click_on 'Adicionar Item ao Lote'

		# Assert
    expect(page).to have_content('Não há itens disponíveis')
    expect(page).not_to have_button('Confirmar Adição')
	end
end