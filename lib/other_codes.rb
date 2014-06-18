class OtherCodes
  def self.create_report 
      user = User.create!(email: "dick@gmail.com", password: "password")
      manager = Manager.create!(first_name: "Kyle", last_name: "Macklroy", company_name: "cj")
      worker = Worker.create!( first_name: "Amal", last_name: "Hudson",company_name: "yy")
      report = Report.create!(report_date: Date.today, manager: manager, worker: worker)
      Equipment.create!(description: "fix nails", part_name: "screws", report: report)
      Task.create!(description: "run the city", report: report)
    return report 
  end  
end 