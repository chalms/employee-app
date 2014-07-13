require 'csv'
class EmployeeCsv
  def initialize(file_data, user)
    @row = 1
    @user = user
    if file_data.respond_to?(:read)
      @data = file_data.read
    elsif file_data.respond_to?(:path)
      @data = File.read(file_data.path)
    else
      puts "Bad file data: #{file_data.class.name}, #{file_data.inspect}"
      raise Exceptions::StdError, "Bad file_data!"
    end
    parse!
  end

  private

  def parse!
    @csv = CSV.parse(@data, :headers => false)
    validate_size!
    @csv.delete_at(0)
    @employee_logs = []
    @csv.each do |row|
      hash = validate_row(row)
      begin
        @employee_logs << @user.company.employee_logs.create!(hash)
      rescue Exceptions::StdError => e
        raise Exceptions::StdError, "Error with csv contents found on line #{@row}: #{e.message}"
      end
    end
  end

  def validate_size!
    raise Exceptions::StdError, "There must be at least two rows present!" unless (@csv.length > 1)
  end

  def three_columns_present?(row)
    raise Exceptions::StdError, "There must be at least three columns present!" unless (r.length > 2)
  end

  def validate_row(r)
    @row += 1
    three_columns_present?(r)
    hash = { :email =>  r[0], :employee_number => r[1], :role => r[2] }
    return hash
  end
end


