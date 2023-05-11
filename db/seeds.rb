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
Item.create!(name: 'Cadeira', description: 'Cadeira gamer', image_url: 'https://m.media-amazon.com/images/I/81fDZaQyoWL.jpg',
  weight: 1200, width: 50, height: 85, depth: 50, category: 'Mobília')
Item.create!(name: 'Tablet', description: 'Tablet 10" da Samsung', image_url: '',
  weight: 320, width: 15, height: 25, depth: 1, category: 'Eletrônico')
lot_a = Lot.create!(code: 'abc123456', start_date: 1.day.from_now, end_date: 1.week.from_now,
  minimum_value: 10, minimal_difference: 5, created_by: user)
lot_b = Lot.create!(code: 'abc987654', start_date: 1.day.from_now, end_date: 1.week.from_now,
  minimum_value: 10, minimal_difference: 5, created_by: user, status: :approved, approved_by: other_user)