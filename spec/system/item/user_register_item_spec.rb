require 'rails_helper'

describe 'Usuário cadastra um item' do
	it 'a partir da tela de itens' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)

		# Act
		login_as user
		visit root_path
    click_on 'Itens'
		click_on 'Cadastrar Item'

		# Assert
		expect(page).to have_field('Nome')
		expect(page).to have_field('Descrição')
		expect(page).to have_field('URL da Imagem')
		expect(page).to have_field('Peso')
		expect(page).to have_field('Largura')
		expect(page).to have_field('Altura')
		expect(page).to have_field('Profundidade')
    expect(page).to have_field('Categoria')
	end

  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
    allow(SecureRandom).to receive(:alphanumeric).and_return('XYZ9876543')
  
    # Act
    login_as user
		visit root_path
    click_on 'Itens'
		click_on 'Cadastrar Item'
    fill_in 'Nome', with: 'Cadeira'
    fill_in 'Descrição', with: 'Cadeira gamer'
    fill_in 'URL da Imagem', with: 'https://m.media-amazon.com/images/I/81fDZaQyoWL.jpg'
    fill_in 'Peso', with: 1200
    fill_in 'Largura', with: 50
    fill_in 'Altura', with: 85
    fill_in 'Profundidade', with: 50
    fill_in 'Categoria', with: 'Mobília'
    click_on 'Enviar'
  
    # Assert
    expect(current_path).to eq items_path
    expect(page).to have_content 'Cadeira'
    expect(page).to have_content 'Código: XYZ9876543'
    expect(page).to have_content 'Categoria: Mobília'
  end

  it 'com dados imcompletos' do
    # Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
  
    # Act
    login_as user
		visit root_path
    click_on 'Itens'
		click_on 'Cadastrar Item'
    fill_in 'Nome', with: ''
    fill_in 'Categoria', with: ''
    click_on 'Enviar'
  
    # Assert
    expect(page).to have_content 'Item não cadastrado'
    expect(page).to have_content 'Categoria não pode ficar em branco'
    expect(page).to have_content 'Nome não pode ficar em branco'
  end
end