require './Rover.rb'

input_data = File.open('input_data.txt', 'r'){ |file| file.read }.split("\n")
plateau_upper_coordinates = input_data.shift.split().map {|coord| coord.to_i}
UPPER_X = plateau_upper_coordinates[0]
UPPER_Y = plateau_upper_coordinates[1]

file = File.new('output_data.txt', 'w')
lines = input_data.length
1.step(lines,2) do |ln|
  x, y, start_direction = input_data[ln-1].split  
  rover = Rover.new 
  if rover.lands?(x.to_i, y.to_i, start_direction)
    rover.rover_moving(input_data[ln]) 
    file.puts rover.output_string
  else file.puts "Uncorrect initial data"   
  end   
end
file.close
