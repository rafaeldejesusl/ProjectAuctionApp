require 'rails_helper'

describe 'Usuário se autentica' do
	it 'com sucesso' do
		# Arrange
		User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
      cpf: CPF.generate)

		# Act
		visit root_path
		click_on 'Entrar'
		fill_in 'E-mail', with: 'joao@email.com'
		fill_in 'Senha', with: 'password'
		within('form') do
			click_on 'Entrar'
		end

		# Assert
		expect(page).not_to have_link 'Entrar'
		expect(page).to have_button 'Sair'
		within('nav') do
			expect(page).to have_content 'joao@email.com'
		end
		expect(page).to have_content 'Login efetuado com sucesso.'
	end

	it 'com falha quando CPF foi bloqueado' do
		# Arrange
		cpf = CPF.generate
		admin = User.create!(name: 'Ana', email: 'ana@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
		User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
      cpf: cpf)
		BlockedCpf.create!(cpf: cpf, reason: "Não pagamento", blocked_by: admin)

		# Act
		visit root_path
		click_on 'Entrar'
		fill_in 'E-mail', with: 'joao@email.com'
		fill_in 'Senha', with: 'password'
		within('form') do
			click_on 'Entrar'
		end

		# Assert
		expect(page).not_to have_content 'Login efetuado com sucesso.'
		expect(page).to have_content 'A sua conta está bloqueada.'
	end

	it 'e faz logout' do
		# Arrange
		User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
      cpf: CPF.generate)
	
		# Act
		visit root_path
		click_on 'Entrar'
		fill_in 'E-mail', with: 'joao@email.com'
		fill_in 'Senha', with: 'password'
		within('form') do
			click_on 'Entrar'
		end
		click_on 'Sair'
	
		# Assert
		expect(page).to have_link 'Entrar'
		expect(page).not_to have_button 'Sair'
		expect(page).not_to have_content 'joao@email.com'
		expect(page).to have_content 'Logout efetuado com sucesso.'
	end
end