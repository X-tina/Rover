class Rover
	attr_accessor :x_coordinate, :y_coordinate, :look_side
	
	def initialize(x, y, p)
		@x_coordinate, @y_coordinate = x, y
		@look_side = p
	end

	Direction = %w[N W S E]
	Action = 'LRM'
	
	@@upper_x = 5
	@@upper_y = 5
	
				
	def rotate(instructions)

		@point = Direction.index(@look_side)
		
		instructions.each_char do |i|
			if i == 'L'
				if @point == Direction.length-1 
					@point = 0 
					next 
				end
				@point += 1				
			elsif i == 'R'
				@point -= 1			
			else 	
				case
				when Direction[@point] == 'S'
					@y_coordinate -=1 
					valid_coordinate(@y_coordinate)
				when Direction[@point] == 'E'
					@x_coordinate += 1
					valid_coordinate(@x_coordinate) 
				when Direction[@point] == 'N'
					@y_coordinate += 1
					valid_coordinate(@y_coordinate) 
				when Direction[@point] == 'W'
					@x_coordinate -= 1
					valid_coordinate(@x_coordinate)								
				end						
			end
		end
		puts "Last coordiates: "
		puts "-------"
		puts @x_coordinate, @y_coordinate, @look_side
		puts "-------"
	end

	private

	def valid_coordinate(var)
		if var == @x_coordinate			
			unless var.between?(0, @@upper_x)
				raise "Error. Overflow"
			end
		else 
			unless var.between?(0, @@upper_y)
				raise "Error. Overflow"
			end
		end				
	end
end
	
	first_rover = Rover.new(1, 2, 'N')
	first_rover.rotate('LMLMLMLMM')

	second_rover = Rover.new(3, 3, 'E')
	second_rover.rotate('MMRMMRMRRM')
	

	


