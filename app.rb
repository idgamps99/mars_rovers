require_relative 'classes/interface'

# Interface.new.run

def parse_coordinates(instruction)
  arr = instruction.gsub(/\s+/, "").chars
  return false unless arr.length == 2
  arr.map do |int|
    int.to_i unless 
  end
end

p parse_coordinates("1       a         ")
