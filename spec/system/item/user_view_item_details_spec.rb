require 'rails_helper'

describe 'Usuário vê detalhes de um item' do
	it 'e vê informações adicionais' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
    allow(SecureRandom).to receive(:alphanumeric).and_return('XYZ9876543')
    item = Item.create!(name: 'Cadeira', description: 'Cadeira gamer', image_url: 'https://m.media-amazon.com/images/I/81fDZaQyoWL.jpg',
      weight: 1200, width: 50, height: 85, depth: 50, category: 'Mobília')

		# Act
		login_as user
		visit root_path
    click_on 'Itens'
    click_on 'Cadeira'		

		# Assert
		expect(page).to have_content('Cadeira')
    expect(page).to have_content('Código: XYZ9876543')
		expect(page).to have_content('Descrição: Cadeira gamer')
		expect(page).to have_content('Peso: 1200 g')
		expect(page).to have_content('Dimensão: 50 cm x 85 cm x 50 cm')
		expect(page).to have_content('Categoria: Mobília')
    img = find('img')
		expect(img[:src]).to eq 'https://m.media-amazon.com/images/I/81fDZaQyoWL.jpg'
	end

  it 'e volta para a tela de itens' do
    # Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
    item = Item.create!(name: 'Cadeira', description: 'Cadeira gamer', image_url: 'https://m.media-amazon.com/images/I/81fDZaQyoWL.jpg',
      weight: 1200, width: 50, height: 85, depth: 50, category: 'Mobília')
  
    # Act
    login_as user
		visit root_path
    click_on 'Itens'
    click_on 'Cadeira'
    click_on 'Voltar'
  
    # Assert
    expect(current_path).to eq items_path
  end
end