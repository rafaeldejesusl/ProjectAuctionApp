require 'rails_helper'

describe 'Usuário visita tela de seus lotes ganhos' do
  it 'quando está autenticado' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Leilões Ganhos'
    
    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'e vê seus lotes ganhos' do
    # Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    other_user = User.create!(name: 'Ana', email: 'ana@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot_a = nil
    lot_b = nil
    travel_to 1.week.ago do
      lot_a = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 3.day.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: user, status: :closed)
      lot_b = Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 3.day.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: other_user, status: :closed)
    end
    Bid.create!(value: 50, user: user, lot: lot_a)
    Bid.create!(value: 50, user: other_user, lot: lot_b)
    
    # Act
    login_as user
    visit root_path
    click_on 'Leilões Ganhos'
    
    # Assert
    expect(page).to have_content 'Lote abc987654'
    expect(page).not_to have_content 'Lote abc123456'
  end
end
