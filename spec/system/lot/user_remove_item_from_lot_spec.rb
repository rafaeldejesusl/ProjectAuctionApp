require 'rails_helper'

describe 'Usuário remove um item do lote' do
  it 'quando lote está em andamento' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
    lot_a = Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
      minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved, approved_by: user)
    Item.create!(name: 'Tablet', description: 'Tablet 10" da Samsung', image_url: '',
      weight: 320, width: 15, height: 25, depth: 1, category: 'Eletrônico', lot: lot_a)

		# Act
		login_as user
		visit root_path
    click_on 'Lotes'
		click_on 'abc123456'

		# Assert
    expect(page).not_to have_button('Remover')
	end

  it 'com sucesso' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
    lot_a = Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
      minimum_value: 10, minimal_difference: 5, created_by: user)
    item = Item.create!(name: 'Tablet', description: 'Tablet 10" da Samsung', image_url: '',
      weight: 320, width: 15, height: 25, depth: 1, category: 'Eletrônico', lot: lot_a)
    Item.create!(name: 'Cadeira', description: 'Cadeira gamer', image_url: '',
      weight: 1200, width: 50, height: 85, depth: 50, category: 'Mobília', lot: lot_a)

		# Act
		login_as user
		visit root_path
    click_on 'Lotes'
		click_on 'abc123456'
    find("button##{item.id}").click

		# Assert
    expect(page).not_to have_content('Tablet')
    expect(page).to have_content('Cadeira')
    expect(page).to have_content('Item removido com sucesso')
	end
end