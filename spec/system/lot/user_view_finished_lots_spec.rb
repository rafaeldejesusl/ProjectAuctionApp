require 'rails_helper'

describe 'Usuário visita tela de lotes finalizados' do
	it 'quando for administrador' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    
		# Act
    login_as user
		visit root_path
		
		# Assert
    expect(page).not_to have_content 'Finalizados'
	end

  it 'e vê lotes finalizados' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 3.day.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
      Lot.create!(code: 'abc123456', start_date: 1.week.from_now, end_date: 3.week.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
		end
    travel_to 5.day.ago do
      Bid.create!(value: 50, user: user, lot: lot)
		end
    
		# Act
    login_as user
		visit root_path
    click_on 'Finalizados'
		
		# Assert
		expect(page).to have_content 'Lotes Finalizados'
    expect(page).to have_content 'Lote abc987654'
    expect(page).to have_content 'Lance Vencedor: 50 R$'
    expect(page).to have_content 'Usuário Vencedor: Joao'
    expect(page).not_to have_content 'Lote abc123456'
	end

  it 'e encerra o lote' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 3.day.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
		end
    travel_to 5.day.ago do
			Bid.create!(value: 50, user: user, lot: lot)
		end
    
		# Act
    login_as user
		visit root_path
    click_on 'Finalizados'
    click_on 'Encerrar Lote'
		
		# Assert
    lot = Lot.find(lot.id)
    expect(lot.status).to eq 'closed'
    expect(page).not_to have_content 'Lote abc987654'
	end

  it 'e cancela o lote' do
		# Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 3.day.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
		end
    Item.create!(name: 'Tablet', description: 'Tablet 10" da Samsung', image_url: '',
      weight: 320, width: 15, height: 25, depth: 1, category: 'Eletrônico', lot: lot)
    
		# Act
    login_as user
		visit root_path
    click_on 'Finalizados'
    click_on 'Cancelar Lote'
		
		# Assert
    lot = Lot.find(lot.id)
    expect(lot.status).to eq 'cancelled'
    expect(page).not_to have_content 'Lote abc987654'
	end

  it 'e o item dos lotes cancelados volta a ficar disponível' do
    # Arrange
    user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 3.day.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved)
		end
    Item.create!(name: 'Tablet', description: 'Tablet 10" da Samsung', image_url: '',
      weight: 320, width: 15, height: 25, depth: 1, category: 'Eletrônico', lot: lot)
    
		# Act
    login_as user
		visit root_path
    click_on 'Finalizados'
    click_on 'Cancelar Lote'
    click_on 'Itens'
		
		# Assert
    expect(page).to have_content 'Tablet'
  end
end