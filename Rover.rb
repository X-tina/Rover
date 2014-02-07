#require 'active_support/core_ext/string'
require 'active_support/all'

class Rover
  attr_accessor :x_coordinate, :y_coordinate

  def initialize(x, y, l)    
    @x_coordinate, @y_coordinate = x, y
    #raise ArgumentError, "Invalid coordinates" unless checkig_coordinate!(@x_coordinate, @y_coordinate)
	  @start_direction = l
    #raise ArgumentError, "Invalid direction" unless valid_direction?
    #Error_message "Invalid direction" unless valid_direction?   
  #ensure return false
  end
 
  DIRECTION = %w[N W S E]
  ACTION = 'LRM'
        
  def rover_moving(instructions)
    @look_side = DIRECTION.index(@start_direction)
    instructions.each_char do |i|
      if i == 'L'	    
        @look_side += 1
        checking_moving_direction				
	    elsif i == 'R'	  	
	      @look_side -= 1
	      checking_moving_direction			
	    else moving_forward
	    end			
    end   
  end  

  def direction
  	DIRECTION[@look_side]
  end

  def output_results
    "#{self.x_coordinate} #{self.y_coordinate} #{self.direction}"
  end

  private

    def moving_forward
      case DIRECTION[@look_side]
      when  'S'
        @y_coordinate -= 1 
        checkig_coordinate!(@x_coordinate, @y_coordinate)
      when 'E'
        @x_coordinate += 1
        checkig_coordinate!(@x_coordinate, @y_coordinate) 
      when 'N'
        @y_coordinate += 1
        checkig_coordinate!(@x_coordinate, @y_coordinate) 
      else 'W'
        @x_coordinate -= 1
        checkig_coordinate!(@x_coordinate, @y_coordinate)
      end   
    end

    def checking_moving_direction
      if @look_side == DIRECTION.length
      	@look_side = 0
      elsif @look_side == -1
      	@look_side = DIRECTION.length-1
      end      		
    end

    def checkig_coordinate!(x, y)
	    unless x.between?(0, UPPER_X) && y.between?(0, UPPER_Y)
        return false
	    end
    end

    def valid_direction?
      DIRECTION.include?(@start_direction)        
    end 
end

input_data = File.open('input_data.txt', 'r'){ |file| file.read }.split("\n")
plateau_upper_coordinates = input_data.shift.split().map {|coord| coord.to_i}
UPPER_X = plateau_upper_coordinates[0]
UPPER_Y = plateau_upper_coordinates[1]

file = File.new('output_data.txt', 'w')
lines = input_data.length
1.step(lines,2) do |ln|
  x, y, start_direction = input_data[ln-1].split  
  rover = Rover.new x.to_i, y.to_i, start_direction
  rover.rover_moving(input_data[ln])  
  file.puts rover.output_results
  file.puts "---------"   
end
file.close
 


	


