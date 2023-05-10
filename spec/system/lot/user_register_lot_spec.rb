require 'rails_helper'

describe 'Usuário cadastra um lote' do
	it 'a partir da tela de lotes' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)

		# Act
		login_as user
		visit root_path
    click_on 'Lotes'
		click_on 'Cadastrar Lote'

		# Assert
		expect(page).to have_field('Código')
		expect(page).to have_field('Data de Início')
		expect(page).to have_field('Data Limite')
		expect(page).to have_field('Valor Mínimo')
		expect(page).to have_field('Diferença Mínima')
	end

	it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
  
    # Act
    login_as user
		visit root_path
    click_on 'Lotes'
		click_on 'Cadastrar Lote'
    fill_in 'Código', with: 'abc123456'
    fill_in 'Data de Início', with: 1.day.from_now
    fill_in 'Data Limite', with: 1.week.from_now
    fill_in 'Valor Mínimo', with: 10
    fill_in 'Diferença Mínima', with: 5
    click_on 'Enviar'
  
    # Assert
    expect(current_path).to eq lots_path
    expect(page).to have_content('Lote abc123456')
    expect(page).to have_content("Data de Início: #{I18n.localize(1.day.from_now.to_date)}")
    expect(page).to have_content("Data Limite: #{I18n.localize(1.week.from_now.to_date)}")
    expect(page).to have_content('Status: Pendente')
  end

	it 'com dados imcompletos' do
    # Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
  
    # Act
    login_as user
		visit root_path
    click_on 'Lotes'
		click_on 'Cadastrar Lote'
    fill_in 'Código', with: ''
    fill_in 'Data de Início', with: ''
    click_on 'Enviar'
  
    # Assert
    expect(page).to have_content 'Lote não cadastrado'
    expect(page).to have_content 'Código não pode ficar em branco'
    expect(page).to have_content 'Data de Início não pode ficar em branco'
  end
end