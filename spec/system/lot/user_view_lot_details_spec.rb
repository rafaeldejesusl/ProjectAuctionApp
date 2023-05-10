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
	end

  it 'e volta para a tela de lotes' do
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
    click_on 'Voltar'
  
    # Assert
    expect(current_path).to eq lots_path
  end
end