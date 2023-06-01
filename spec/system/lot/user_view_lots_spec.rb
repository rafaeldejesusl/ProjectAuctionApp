require 'rails_helper'

describe 'Usuário visita tela de lotes' do
	it 'quando está autenticado' do
		# Arrange
    
		# Act
		visit root_path
		
		# Assert
    within('nav') do
		  expect(page).not_to have_content 'Lotes'
    end
	end

  it 'como administrador' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
      cpf: CPF.generate)
    
		# Act
    login_as user
		visit root_path
		
		# Assert
    within('nav') do
		  expect(page).not_to have_content 'Lotes'
    end
	end

  it 'e vê lotes cadastrados' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
    lot_a = Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
      minimum_value: 10, minimal_difference: 5, created_by: user)
    lot_b = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 1.week.from_now,
      minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
    
		# Act
    login_as user
		visit root_path
    click_on 'Lotes'
		
		# Assert
		expect(page).not_to have_content('Não existem lotes cadastrados')
    expect(page).to have_content('Lote abc123456')
    expect(page).to have_content("Data de Início: #{I18n.localize(lot_a.start_date)}")
    expect(page).to have_content("Data Limite: #{I18n.localize(lot_a.end_date)}")
    expect(page).to have_content('Status: Pendente')
    expect(page).to have_content('Lote abc987654')
    expect(page).to have_content("Data de Início: #{I18n.localize(lot_b.start_date)}")
    expect(page).to have_content("Data Limite: #{I18n.localize(lot_b.end_date)}")
    expect(page).to have_content('Status: Aprovado')
	end

  it 'e não existem lotes cadastrados' do
    # Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
  
    # Act
    login_as user
    visit root_path
    click_on 'Lotes'
  
    # Assert
    expect(page).to have_content('Não existem lotes cadastrados')
  end
end