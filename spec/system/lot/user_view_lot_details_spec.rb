require 'rails_helper'

describe 'Usuário vê detalhes de um lote' do
	it 'e vê informações adicionais' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
    lot_a = Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
      minimum_value: 10, minimal_difference: 5, created_by: user)

		# Act
		login_as user
		visit root_path
    click_on 'Lotes'
    click_on 'Lote abc123456'		

		# Assert
		expect(page).to have_content('Lote abc123456')
    expect(page).to have_content("Data de Início: #{I18n.localize(lot_a.start_date)}")
    expect(page).to have_content("Data Limite: #{I18n.localize(lot_a.end_date)}")
    expect(page).to have_content('Status: Pendente')
		expect(page).to have_content('Valor Mínimo: 10 R$')
		expect(page).to have_content('Diferença Mínima: 5 R$')
		expect(page).to have_content('Criado por: Joao')
    expect(page).to have_content('Não existem itens neste lote')
	end

  it 'e vê itens adicionados ao lote' do
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
      weight: 1200, width: 50, height: 85, depth: 50, category: 'Mobília', lot: lot_a)

		# Act
		login_as user
		visit root_path
    click_on 'Lotes'
    click_on 'Lote abc123456'		

		# Assert
		expect(page).to have_content('Itens deste Lote')
		expect(page).to have_content('Cadeira')
		expect(page).not_to have_content('Tablet')
    expect(page).to have_content('Canivete')
	end

  it 'e volta para a tela de lotes' do
    # Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
    Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
      minimum_value: 10, minimal_difference: 5, created_by: user)
  
    # Act
    login_as user
		visit root_path
    click_on 'Lotes'
    click_on 'Lote abc123456'
    click_on 'Voltar'
  
    # Assert
    expect(current_path).to eq lots_path
  end
end