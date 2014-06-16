class OtherCodes
  def self.create_report 
      user = User.create!( first_name: "Amal", last_name: "Hudson", email: "dick@gmail.com", password: "password", role: "user", password_confirmation: "password")
      manager = Manager.create!(first_name: "Kyle", last_name: "Macklroy", company_name: "cj")
      worker = Worker.create!( first_name: "Amal", last_name: "Hudson",company_name: "yy")
      report = Report.create!(report_date: Date.today, manager: manager, worker: worker)
      Equipment.create!(description: "fix nails", part_name: "screws", report: report)
      Task.create!(description: "run the city", report: report)
    return report 
  end 


  def alternative_auth
     user_email = params[:email].presence
      user       = User.find_by_email(user_email)
    if user && Devise.secure_compare(user.authentication_token, params[:auth_token])
      sign_in user, store: false
    else 
      redirect_to(controller: "resource", action: "create", params: params)
    end 
  end 
end 