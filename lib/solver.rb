class Charset
	attr_accessor :value, :index, :next, :prev
	def initialize(val, i)
		@value = val 
		@index = i 
	end
end  

class WindowQueue 
	attr :head, :tail, :t, :match, :low, :high
	def initialize(char, t)
		@tail = char 
		@head = char
		@t = t
		@match = []
	end 

	def size(size = nil)
		if (size.present?)
			if ((size < @size.to_i) || (!@size.present?))
				@size = size 
				@low = head.next.index 
				@high = tail.index
			end 
		end 
		@size
	end 

	def cycle(v)
		return unless (v.next.value.present?)
		while (v.value == v.next.value)
			v.next.prev = v
			v = v.next
			@match.delete_at(@match.find_index(v.value))
			return unless (v.next.value.present?)
		end 
	end 

	def push(char)
		@match << char.value
		@tail.next = char 
		char.prev = @tail
		@tail = char
		cycle(@head)
		cycle(@tail.prev)
	end

	def pop
		@match.delete_at(@match.find_index(@head.value))
		@head = @head.next 
	end

	def status 
		if (@match.uniq.sort == @t.sort)
			s = @tail.index - @head.next.index
			return (size(s))
		end
	end 
end 

class Solver
	attr_accessor :t, :s, :w, :solution

	def initialize
		@t = "ABC"
		@s = "ADOBECOADCB"
		@t = t.split("")
		@s = s.split("")
		solve!
		@solution = @s[@w.low...@w.high+1]
	end 

	def solve!
		lock = true 
		index = 0 
		@s.each do |char|
			if (@t.include?(char) && lock)
				@w = WindowQueue.new(Charset.new(char, index), t)
				lock = false 
			elsif (@t.include?(char) && (!lock))
				@w.push(Charset.new(char, index))
				if (!lock) 
					secondary = @w.status
					if (secondary.present?) 
						@w.pop  if (@w.head.index < (index-secondary))
						secondary = @w.status 
					end 
				end 
			end 
			index += 1
		end 
	end 
end 









