require 'rails_helper'

describe 'Usuário visualiza CPFs bloqueados' do
  it 'quando for administrador' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
		
		# Act
		login_as user
		visit('/')
		
		# Assert
    expect(page).not_to have_content 'Lista de Bloqueados'
	end

  it 'e vê lista de CPFs bloqueados' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
    cpf_1 = CPF.generate
    cpf_2 = CPF.generate
    BlockedCpf.create!(cpf: cpf_1, blocked_by: user, reason: "Não pagamento")
    BlockedCpf.create!(cpf: cpf_2, blocked_by: user, reason: "Quebra dos termos de uso")

		# Act
		login_as user
		visit root_path
    click_on 'Lista de Bloqueados'
		
		# Assert
    expect(page).to have_content "#{cpf_1} : Não pagamento"
    expect(page).to have_content "#{cpf_2} : Quebra dos termos de uso"
	end

	it 'quando a lista estiver vazia' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)

		# Act
		login_as user
		visit root_path
    click_on 'Lista de Bloqueados'
		
		# Assert
    expect(page).to have_content 'Não existem CPFs bloqueados'
	end
end