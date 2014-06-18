class Report < ActiveRecord::Base
	has_many :tasks
	belongs_to :manager
	has_many :users
	has_one :location, as: :checkin, :polymorphic => :true
	has_one :location, as: :checkout, :polymorphic => :true

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
		h[:equipment] = [] 
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
		update_equipment(report_updates.delete(:equipment))
		if (report_updates.size > 0)
			puts "Updating : #{report_updates}" 
			self.update_attributes!(report_updates)
		end 
	end 
end