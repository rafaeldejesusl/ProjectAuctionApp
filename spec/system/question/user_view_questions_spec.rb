require 'rails_helper'

describe 'Usuário visualiza as perguntas' do
  it 'na tela do leilão' do
		# Arrange
		admin = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
			cpf: CPF.generate)
		user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
    other_lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 2.week.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
      other_lot = Lot.create!(code: 'abc123456', start_date: 2.week.from_now, end_date: 3.week.from_now,
        minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
		end
    Question.create!(content: "Quanto é?", user: user, lot: lot)
    Question.create!(content: "Ser ou não ser?", user: user, lot: other_lot)
		
		# Act
		login_as user
		visit('/')
    click_on 'abc987654'
		
		# Assert
		expect(page).to have_content('Perguntas')
    expect(page).to have_content('Quanto é?')
    expect(page).not_to have_content('Ser ou não ser?')
	end

  it 'quando a visibilidade for verdadeira' do
		# Arrange
		admin = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
			cpf: CPF.generate)
		user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
    lot = nil
		travel_to 1.week.ago do
			lot = Lot.create!(code: 'abc987654', start_date: 2.week.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
		end
    Question.create!(content: "Quanto é?", user: user, lot: lot)
    Question.create!(content: "Ser ou não ser?", user: user, lot: lot, visible: false)
		
		# Act
		login_as user
		visit('/')
    click_on 'abc987654'
		
		# Assert
		expect(page).to have_content('Perguntas')
    expect(page).to have_content('Quanto é?')
    expect(page).not_to have_content('Ser ou não ser?')
	end

  it 'quando não houver perguntas' do
		# Arrange
		admin = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
			cpf: CPF.generate)
		user = User.create!(name: 'Joao', email: 'joao@email.com.br', password: 'password',
      cpf: CPF.generate)
		travel_to 1.week.ago do
			Lot.create!(code: 'abc987654', start_date: 2.week.from_now, end_date: 3.week.from_now,
				minimum_value: 10, minimal_difference: 5, created_by: admin, status: :approved)
		end
		
		# Act
		login_as user
		visit('/')
    click_on 'abc987654'
		
		# Assert
		expect(page).to have_content('Não existem perguntas neste lote')
	end
end