# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
user = User.create!( first_name: "Amal", last_name: "Hudson", email: "dick@gmail.com", password: "password", password_confirmation: "password")
manager = Manager.create!(first_name: "Kyle", last_name: "Macklroy", company_name: "cj")
worker = Worker.create!( first_name: "Amal", last_name: "Hudson",company_name: "yy")
report = Report.create!(report_date: Date.today, manager: manager, worker: worker)
Equipment.create!(description: "fix nails", part_name: "screws", report: report)
Task.create!(description: "run the city", report: report)
