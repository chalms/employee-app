require 'csv'
class EmployeeCsv
  attr_reader :employee_logs
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
      employee_log = nil
      begin
        begin
            hash = validate_row(row)
            puts hash
            puts "#{@user.company.employee_logs.inspect}"
            employee_log = @user.company.employee_logs.create!(hash)
        rescue Exceptions::StdError => e
          raise Exceptions::StdError, "Error with csv contents found on line #{@row}: #{e.message}"
        end
      rescue ActiveRecord::RecordInvalid => e
        puts e.to_s
      end
      if (employee_log)
        @employee_logs << employee_log
      end
    end
  end

  def validate_size!
    raise Exceptions::StdError, "There must be at least two rows present!" unless (@csv.length > 1)
  end

  def three_columns_present?(row)
    raise Exceptions::StdError, "There must be at least three columns present!" unless (row.length > 2)
  end

  def validate_row(r)
    @row += 1
    three_columns_present?(r)
    puts "#{r[0]}, #{r[1]}, #{r[2]}"
    hash = { :email =>  r[0].gsub('/\s+/',""), :employee_number => r[1].gsub('/\s+/',""), :role => r[2].gsub('/\s+/',""), :company_id => @user.company.id }
    return hash
  end
end


