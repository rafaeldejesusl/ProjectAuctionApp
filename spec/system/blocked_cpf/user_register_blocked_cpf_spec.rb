require 'rails_helper'

describe 'Usuário registra CPFs bloqueados' do
  it 'a partir da tela de CPFs bloqueados' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
		
		# Act
		login_as user
		visit('/')
    click_on 'Lista de Bloqueados'
    click_on 'Bloquear novo CPF'
		
		# Assert
    expect(page).to have_field 'CPF'
    expect(page).to have_field 'Motivo'
	end

  it 'com sucesso' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
    cpf = CPF.generate
		
		# Act
		login_as user
		visit('/')
    click_on 'Lista de Bloqueados'
    click_on 'Bloquear novo CPF'
    fill_in 'CPF', with: cpf
    fill_in 'Motivo', with: 'Não pagamento'
    click_on 'Enviar'
		
		# Assert
    expect(page).to have_content "#{cpf} : Não pagamento"
    expect(page).to have_content 'CPF bloqueado com sucesso'
	end

  it 'com dados inválidos' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
		
		# Act
		login_as user
		visit('/')
    click_on 'Lista de Bloqueados'
    click_on 'Bloquear novo CPF'
    fill_in 'CPF', with: '00000000000'
    fill_in 'Motivo', with: 'Não pagamento'
    click_on 'Enviar'
		
		# Assert
    expect(page).to have_content 'CPF não é válido'
    expect(page).to have_content 'CPF não foi bloqueado'
	end
end