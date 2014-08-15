require 'active_support/all'

class Rover
  attr_accessor :x_coordinate, :y_coordinate
  attr_reader :output_string
  DIRECTION = %w[N W S E] 

  def rover_moving(instructions)
    @look_side = DIRECTION.index(@start_direction)
    instructions.each_char do |i|
      if i == 'L'	    
        @look_side += 1       
     elsif i == 'R'
       @look_side -= 1 
     elsif !moving_forward
        self.output_string = "Uncorrect instructions"
        break
      else self.output_string = "#{self.x_coordinate} #{self.y_coordinate} #{self.direction}"
    end
      checking_moving_direction
    end   
  end

  def lands?(x, y, direction)
     @x_coordinate, @y_coordinate = x, y
     @start_direction = direction
     (valid_direction? && valid_coordinate?(@x_coordinate, @y_coordinate))
  end  

  def direction
    DIRECTION[@look_side]
  end

  private

  attr_writer :output_string

  def moving_forward      
    case DIRECTION[@look_side]
    when 'S'
      @y_coordinate -= 1         
    when 'E'
      @x_coordinate += 1       
    when 'N'
      @y_coordinate += 1        
    when 'W'
      @x_coordinate -= 1    
    end  
    valid_coordinate?(@x_coordinate, @y_coordinate)
  end

  def checking_moving_direction
    if @look_side == DIRECTION.length
      @look_side = 0
    elsif @look_side == -1
      @look_side = DIRECTION.length-1
    end      		
  end

  def valid_coordinate?(x, y)     
    x.between?(0, UPPER_X) && y.between?(0, UPPER_Y)
  end

  def valid_direction?
    DIRECTION.include?(@start_direction)        
  end
end
