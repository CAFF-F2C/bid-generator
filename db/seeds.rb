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

AdminUser.create_with(
  full_name: 'Admin User',
  password: 'password',
  password_confirmation: 'password'
).find_or_create_by!(email: 'adminUser@example.com')

score_categories_seeds = YAML.load_file(Rails.root.join('db', 'seeds', 'score_categories.yml'))
score_categories_seeds.each_with_index { |values, index| ScoreCategory.create_with(position: index).find_or_create_by(values) }
