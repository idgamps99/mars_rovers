require_relative 'plateau'
require_relative 'rover'

class Interface
  def initialize
    @errors = {
      invalidpos: "\nERROR: ROVER START POSITION OUT OF BOUNDS"
    }
    @directions = "\nYou will continue to be prompted until your responses fit these criteria:\n
      1 - All coordinates must be only two integers\n
      2 - A rover's start position must contain it coordinates followed by it orientation [N, E, S, W]\n
      3 - A rover's movement instructions must only contain [L, R, M] and must not lead the rover out of bounds\n"
    @messages = {
      prompt1: "\nEnter upper right coordinates of plateau: ",
      prompt2: "Enter starting coordinates Rover 1: ",
      prompt3: "Enter movement commands for Rover 1: ",
      prompt4: "Enter starting coordinates Rover 2: ",
      prompt5: "Enter movement commands for Rover 2: "
    }
  end

  def run
    instructions = get_instructions
    unless instantiate_classes(instructions)
      puts @errors[:invalidco1]
      self.run
    end
    enact_instructions
    # output_status
  end

  private

  def get_instructions
    # user will continue to be prompted until a correct instruction is received
    puts @directions
     instructions = @messages.map do |key, message|
      loop do
        @response = validate_instruction(prompt(message), key)
        break if @response
      end
      @response
    end
    instructions
  end

  def prompt(prompt)
    print prompt
    gets.chomp
  end

  # def validate_instruction(instruction, key)
  #   parse_instruction(instruction, key)
  # end

  def validate_instruction(instruction, key)
    case key
    when :prompt1           then parse_coordinates(instruction)
    when :prompt2, :prompt4 then parse_rover_positions(instruction)
    when :prompt3, :prompt5 then parse_movements(instruction)
    end
  end

  def parse_coordinates(instruction)
    two_ints = /^\d{2}$/
    strip_white_spaces(instruction)
    return false unless two_ints.match?(instruction)
    instruction.chars.map(&:to_i)
  end

  def parse_rover_positions(instruction)
    valid_position = /^\d{2}[neswNESW]{1}$/ # NSEW + 2 integers
    strip_white_spaces(instruction)
    return false unless valid_position.match?(instruction)
    instruction.chars.each_with_index.map do |char, index|
      index == 0 ? char.upcase : char.to_i
    end
  end

  def parse_movements(instruction)
    valid_movement = /^[lrmLRM]+$/
    strip_white_spaces(instruction)
    return false unless valid_movement.match?(instruction)
    instruction.upcase
  end

  def strip_white_spaces(instruction)
    instruction.gsub!(/\s+/, "") unless nil
  end

  def instantiate_classes(instructions)
    @plateau = Plateau.new(instructions[0][0], instructions[0][1])
    @rover1 = Rover.new(instructions[1][0], instructions[1][1], instructions[1][2])
    @rover2 = Rover.new(instructions[3][0], instructions[3][1], instructions[3][2])
    check_valid_start_positions
  end

  def check_valid_start_positions
    return false unless @plateau.within_bounds?([@rover1.x_position, @rover1.y_position])
    return false unless @plateau.within_bounds?([@rover2.x_position, @rover2.y_position])
    return false if @rover1.x_position == @rover2.x_position || @rover1.y_position == @rover2.y_position
    true
  end

  def enact_instructions
    # move rover
    # track rover
    # move rover
    # track rover
  end

  def move_rover(rover)
  end

  def track_rover
  end

  def output_status
  end

end
