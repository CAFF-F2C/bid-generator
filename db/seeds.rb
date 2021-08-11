# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Buyer.create_with(
  full_name: 'District Buyer',
  password: 'password',
  password_confirmation: 'password'
).find_or_create_by!(
  email: 'user@example.com'
).update!(
  confirmed_at: 1.second.ago
)
