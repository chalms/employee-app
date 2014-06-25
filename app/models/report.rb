class Report < ActiveRecord::Base
	
  include JsonSerializingModel
  
	# has_many :tasks
	# has_and_belongs_to_many :users
	# has_one :location, as: :checkin
	# has_one :location, as: :checkout

	def self.is_active? 
		if (self.report_date == Date.today) 
			return true 
		else 
			return false 
		end 
	end 

	def as_hash
		h = self.serializable_hash
		h[:manager] = manager.serializable_hash
		h[:tasks] = []
		self.tasks.each do |t|
			h[:tasks] << t.serializable_hash
		end 
		return h
	end
		
	def update_tasks(tasks_hash)
		puts "Task hash: #{tasks_hash}" 
		if (tasks_hash.present?)
			if (equipment_hash.kind_of? (Hash)) 
				tasks_hash.each do |t|
					task = self.tasks.find_by(id: t.delete[:id])
					task.update_attributes!(t) if (task.present? && t.size > 0)
				end 
			end
		end 
	end 

	def update(report_updates) 
		puts "Report Updates : #{equipment_hash}" 
		update_tasks(report_updates.delete(:tasks))
		if (report_updates.size > 0)
			puts "Updating : #{report_updates}" 
			self.update_attributes!(report_updates)
		end 
	end 
end