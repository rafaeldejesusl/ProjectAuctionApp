require 'rails_helper'

describe 'Usuário se cadastra' do
	it 'com sucesso como usuário' do
		# Arrange

		# Act
		visit root_path
		click_on 'Entrar'
		click_on 'Criar uma conta'
		fill_in 'Nome', with: 'Maria'
		fill_in 'E-mail', with: 'maria@email.com'
    fill_in 'CPF', with: CPF.generate
		fill_in 'Senha', with: 'password'
		fill_in 'Confirme sua senha', with: 'password'
		click_on 'Criar conta'

		# Assert
		expect(page).to have_content 'maria@email.com'
		expect(page).to have_button 'Sair'
		expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso'
		user = User.last
		expect(user.name).to eq 'Maria'
    expect(user.admin).to eq false
	end

  it 'com sucesso como administrador' do
		# Arrange

		# Act
		visit root_path
		click_on 'Entrar'
		click_on 'Criar uma conta'
		fill_in 'Nome', with: 'Maria'
		fill_in 'E-mail', with: 'maria@leilaodogalpao.com.br'
    fill_in 'CPF', with: CPF.generate
		fill_in 'Senha', with: 'password'
		fill_in 'Confirme sua senha', with: 'password'
		click_on 'Criar conta'

		# Assert
		expect(page).to have_content 'maria@leilaodogalpao.com.br'
		expect(page).to have_button 'Sair'
		expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso'
		user = User.last
		expect(user.name).to eq 'Maria'
    expect(user.admin).to eq true
	end
end