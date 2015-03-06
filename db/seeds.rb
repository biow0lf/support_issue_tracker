# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Status.create!(
  name: 'Waiting for Staff Response'
)
Status.create!(
  name: 'Waiting for Customer'
)
Status.create!(
  name: 'On Hold'
)
Status.create!(
  name: 'Cancelled'
)
Status.create!(
  name: 'Completed'
)
Department.create!(
  name: 'IT'
)
Department.create!(
  name: 'Sales'
)
