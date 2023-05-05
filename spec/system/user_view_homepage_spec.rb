require 'rails_helper' # Importação das configurações de test

describe 'Usuário visita tela inicial' do
	it 'e vê o nome do app' do
		# Arrange
		
		# Act
		visit('/')
		
		# Assert
		expect(page).to have_content('Leilão de Estoque')
	end
end