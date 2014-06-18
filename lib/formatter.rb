class Formatter
	def self.get_start_time(date_string, options = {})
		if date_string == "today"
			DateTime.current
		elsif date_string == "ytd"
			DateTime.new(DateTime.current.year, 1, 1, 9, 30)
		end
	end

	def self.last_market_date
	    Formatter.get_market_date(Date.today)
	end

	def self.get_market_datetime(datetime, options = {})
		date = datetime

		unless date.present?
		  date = options[:default]
	  	if (options[:error] == "rescue - nil")
		  	return nil
		  end
		  if date.blank?
		  	raise Exceptions::StdError, "No DateTime Given" if options[:nil_date_rescue] == "no rescue"
		  end
		end

		if date.is_a? String
			begin
				date = Date.parse(date).to_date
				while [0,6].include?(time_save.wday)
					date -= 1
				end
			rescue
				date = options[:default]
				if options[:error] == "rescue - nil"
			  	return nil
			  end
			  if date.blank?
					raise Exceptions::StdError, "Invalid DateTime" if options[:error] == "no rescue"
				end
			end
		end

		if date.is_a? DateTime
			time_save = date
			date = date.to_date
		end

		weekend_enum = [0,6]
		begin
			while weekend_enum.include?(date.wday)
				date -= 1
				time_save = nil
			end
		rescue
			raise Exceptions::StdError, "Invalid DateTime - When looking for weekend in loop"
		end

		if options[:day_before].present?
			date = date - 1
			while [0, 6].include?(date.wday)
				date = date - 1
			end
		end

		#use the exact time if time_save is present, if not, use the market open
		if time_save.present?
			date = time_save
		elsif options[:open].blank?
			date = date.to_time + (60 * 60 * 16) #for market close
		else
			date = date.to_time + (60 * 60 * 9.5) #for market open
		end
		date
	end


	def self.get_market_date(date, options = {})
		#assuming taking market close
		#options[:default] is to set the error rescue date value if we want to continue calculations
		#options[:error] is to set a value to return immediatly after an exception is thrown

		unless date.present?
		  date = options[:default]
	  	if options[:error] == "rescue - nil"
		  	return nil
		  end
		  if date.blank?
		  	raise Exceptions::StdError, "No Date Given"
		  end
		end

		if date.is_a? DateTime
			return get_market_datetime(date)
		end

		if date.is_a? String
			begin
				date = Date.parse(date)
			rescue
				date = options[:default]
				return nil if (options[:error] == "rescue - nil")
			  if date.blank?
					raise Exceptions::StdError, "Invalid Date"
					return
				end
			end
		end

		while [0,6].include?(date.wday)
			date -= 1
		end

		if options[:day_before].present?
			date = get_market_date(date)
		end

		date
	end

	def self.to_money(number, options = {})
		if number.is_a? String
			number = number.to_f
		end

		decimals = 2

		if options[:round].present?
			decimals = options[:round]
		end

		begin
			num = ActionController::Base.helpers.number_to_currency(number, {
				:negative_format => "(%u%n)",
				:precision => decimals,
				:raise => true
				} )
		rescue => e
			num = options[:default]
			puts e.message
			raise Exceptions::StdError, "Number Cannot be a word!" if options[:error] == "no rescue"
		end

		num
	end

	def self.to_percent(number, options = {})
  	decimals = 2
  	if options[:round].present?
  		decimals = options[:round]
  	end

  	begin
  		num = number_to_precision({
  			:precision => decimals,
  			:raise => true })
  	rescue
  		num = options[:default]
  		raise Exceptions::StdError, "Invalid Percent Value" if options[:error] == "no rescue"
  	end
  	num
	end


	def self.to_f(number, options = {})
		decimals = 2

		if options[:round].present?
			decimals = options[:round]
		end

		begin
			num = number.to_f.round(decimals)
		rescue
		  num = options[:default]
			raise Exceptions::StdError, "Number Cannot be a word!" if options[:error] == "no rescue"
		end

		if options[:error] == "raise zero exception" && number == 0
			num = options[:default]
			raise Exceptions::StdError, "Number Cannot be zero" if options[:error] == "no rescue"
		end

		num
	end
end
