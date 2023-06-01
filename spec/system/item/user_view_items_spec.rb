require 'rails_helper'

describe 'Usuário visita tela de itens' do
	it 'quando está autenticado' do
		# Arrange
    
		# Act
		visit root_path
		
		# Assert
		expect(page).not_to have_content 'Itens'
	end

  it 'como administrador' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
      cpf: CPF.generate)
    
		# Act
    login_as user
		visit root_path
		
		# Assert
    expect(page).not_to have_content 'Itens'
	end

  it 'e vê itens cadastrados' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC1234567')
    Item.create!(name: 'Tablet', description: 'Tablet 10" da Samsung', image_url: '',
      weight: 320, width: 15, height: 25, depth: 1, category: 'Eletrônico')
    allow(SecureRandom).to receive(:alphanumeric).and_return('XYZ9876543')
    Item.create!(name: 'Cadeira', description: 'Cadeira gamer', image_url: '',
      weight: 1200, width: 50, height: 85, depth: 50, category: 'Mobília')
    
		# Act
    login_as user
		visit root_path
    click_on 'Itens'
		
		# Assert
		expect(page).not_to have_content('Não existem itens cadastrados')
    expect(page).to have_content('Tablet')
    expect(page).to have_content('Código: ABC123456')
    expect(page).to have_content('Categoria: Eletrônico')
    expect(page).to have_content('Cadeira')
    expect(page).to have_content('Código: XYZ987654')
    expect(page).to have_content('Categoria: Mobília')
	end

  it 'e não existem itens cadastrados' do
    # Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
  
    # Act
    login_as user
    visit root_path
    click_on 'Itens'
  
    # Assert
    expect(page).to have_content('Não existem itens cadastrados')
  end
end