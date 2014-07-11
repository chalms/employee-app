class Signup
  attr_reader :email, :name, :employee_number, :password, :companies
  def initialize
    @email = ""
    @name = ""
    @employee_number = ""
    @password = ""
    @companies = companies
  end

  def companies
    @companies = []
    Company.all.each { |c| @companies << c.name }
    @companies
  end

  def update(params = {})
    params = params[:sign_up] if (params[:sign_up])
    @email = (params[:email] || @email)
    @name = (params[:name] || @name)
    @employee_number = (params[:employee_number] || @employee_number)
    @password = (params[:password] || @password)
    @company_id = (params[:company_id].to_i || @company)
  end

  def save!
    @company = Company.find(id: @company)
    validate_company!
    company_logs = @company.employee_logs.find_by_employee_number(@employee_number)
    validate_company_logs!(company_logs)

    return @company.users.create!({
      "role" => company_logs.role,
      "email" => @email,
      "name" => @name,
      "employee_number" => @employee_number,
      "password" => @password
    })
  end

  private

  def validate_params!(params)
    raise Exceptions::StdError, "A valid email is required!" unless (params[:email])
    raise Exceptions::StdError, "An employee number is required!" unless (params[:employee_number])
    raise Exceptions::StdError, "Please select a company!" unless (params[:company_id])
  end

  def validate_employee_logs!(company, params)
    employee_log = company.employee_logs.where(:employee_number => params[:employee_number]).andand.first
    raise Exceptions::StdError, "Employee that was given does not match any existing records!" unless employee_log
    return employee_log
  end

  def validate_create_user!
    raise Exceptions::StdError, "Token is not valid!" unless (@token)
    raise Exceptions::StdError, "Sorry there must be an error on our end... We are fixing it as quick as possible" unless(@user)
  end

  def validate_company!
    raise Exceptions::StdError, "company could not be saved" unless(@company)
  end

  def validate_company_logs!(company_logs)
    raise Exceptions::StdError, "company logs could not be found" unless(company_logs)
  end
end