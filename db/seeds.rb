# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.create(:name => "Admin")
Role.create(:name => "User")
User.create(:name => "Admin", :email => "admin@navodayans.com", :password => "test1234",
:password_confirmation => "test1234", :role_id => 1, :batch => "12")
User.create(:name => "User", :email => "user@navodayans.com", :password => "test1234",
:password_confirmation => "test1234", :role_id => 2, :batch => "12")