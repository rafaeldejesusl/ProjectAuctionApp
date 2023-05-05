require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#valid?' do
		it 'falso quando o nome é vazio' do
			# Arrange
			item = Item.new(name: '', description: 'Cadeira gamer', image_url: '',
        weight: 1200, width: 50, height: 85, depth: 50, category: 'Mobília')

			# Act
			result = item.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando a categoria é vazia' do
			# Arrange
			item = Item.new(name: 'Cadeira', description: 'Cadeira gamer', image_url: '',
        weight: 1200, width: 50, height: 85, depth: 50, category: '')

			# Act
			result = item.valid?

			# Assert
			expect(result).to eq false
		end

    it 'deve ter um código' do
			# Arrange
			item = Item.new(name: 'Cadeira', description: 'Cadeira gamer', image_url: '',
        weight: 1200, width: 50, height: 85, depth: 50, category: 'Mobília')

			# Act
			result = item.valid?

			# Assert
			expect(result).to eq true
		end
  end

  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do
      # Arrange
      item = Item.new(name: 'Cadeira', description: 'Cadeira gamer', image_url: '',
        weight: 1200, width: 50, height: 85, depth: 50, category: 'Mobília')
  
      # Act
      item.save!
      result = item.code
  
      # Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 10
    end

    it 'de forma única' do
      # Arrange
      first_item = Item.create!(name: 'Cadeira', description: 'Cadeira gamer', image_url: '',
        weight: 1200, width: 50, height: 85, depth: 50, category: 'Mobília')
      second_item = Item.new(name: 'Tablet', description: 'Tablet 10" da Samsung', image_url: '',
        weight: 320, width: 15, height: 25, depth: 1, category: 'Eletrônico')

      # Act
      second_item.save!

      # Assert
      expect(second_item.code).not_to eq first_item.code
    end
  end
end
