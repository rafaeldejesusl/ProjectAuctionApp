# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create!(name: 'Joao', email: 'joao@email.com', password: 'password',
  cpf: CPF.generate)
user = User.create!(name: 'Ana', email: 'ana@leilaodogalpao.com.br', password: 'password',
  cpf: CPF.generate)
other_user = User.create!(name: 'Joao', email: 'joao@leilaodogalpao.com.br', password: 'password',
  cpf: CPF.generate)
User.create!(name: 'Bia', email: 'bia@email.com', password: 'password',
  cpf: CPF.generate)
BlockedCpf.create!(cpf: CPF.generate, blocked_by: user, reason: "Não pagamento")
BlockedCpf.create!(cpf: CPF.generate, blocked_by: user, reason: "Quebra dos termos de uso")
item = Item.create!(name: 'Cadeira', description: 'Cadeira gamer',
  weight: 1200, width: 50, height: 85, depth: 50, category: 'Mobília')
item.image.attach(io: File.open(Rails.root.join("spec/support/imgs/cadeira.jpg")), filename: 'cadeira.jpg')
Item.create!(name: 'Tablet', description: 'Tablet 10" da Samsung',
  weight: 320, width: 15, height: 25, depth: 1, category: 'Eletrônico')
lot_a = Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
  minimum_value: 10, minimal_difference: 5, created_by: user)
lot_b = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 1.month.from_now,
  minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved, approved_by: other_user)
Lot.insert_all([
  {code: 'xyz987654', start_date: 1.day.ago, end_date: 1.month.from_now,
    minimum_value: 10, minimal_difference: 5, created_by_id: user.id, status: :approved, approved_by_id: other_user.id},
  {code: 'xyz123456', start_date: 1.week.ago, end_date: 1.day.ago,
    minimum_value: 10, minimal_difference: 5, created_by_id: user.id, status: :approved, approved_by_id: other_user.id},
  {code: 'aei123456', start_date: 1.week.ago, end_date: 1.day.ago,
    minimum_value: 10, minimal_difference: 5, created_by_id: user.id, status: :approved, approved_by_id: other_user.id},
  {code: 'aei987654', start_date: 1.day.ago, end_date: 1.month.from_now,
    minimum_value: 10, minimal_difference: 5, created_by_id: user.id, status: :approved, approved_by_id: other_user.id}
])
Bid.insert_all([
  { value: 50, user_id: other_user.id, lot_id: 4 }
])
Bid.create!(value: 12, user_id: 1, lot_id: 6)
Bid.create!(value: 20, user_id: 4, lot_id: 6)
Item.create!(name: 'Tablet', description: 'Tablet 10" da Samsung',
  weight: 320, width: 15, height: 25, depth: 1, category: 'Eletrônico', lot_id: 5)
Question.create!(content: 'Quais métodos de pagamento?', user_id: 4, lot_id: 2)
Question.create!(content: 'Tem em outra cor?', user_id: 1, lot_id: 2)
Answer.create!(content: 'No cartão ou pix', user_id: 2, question_id: 1)
Favorite.create!(user_id: 1, lot_id: 2)
Favorite.create!(user_id: 1, lot_id: 3)