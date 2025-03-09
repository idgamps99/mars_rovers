require_relative 'plateau'
require_relative 'rover'

class Interface
  ERRORS = {
    invalidpos: "\nERROR: INVALID ROVER STARTING POSITION",
    invalidmove: "\nERROR: INVALID ROVER MOVE"
  }

  DIRECTIONS = "\nYou will continue to be asked the following until your responses fulfill all criteria:\n
    1 - All coordinates must be only two integers\n
    2 - A rover's start position must contain it coordinates followed by its orientation [N, E, S, W]\n
    3 - A rover's movement instructions must only contain [L, R, M] and must not lead the rover out of bounds\n"

  MESSAGES = {
    prompt1: "\nEnter upper right coordinates of plateau: ",
    prompt2: "\nEnter starting coordinates Rover 1: ",
    prompt3: "\nEnter movement commands for Rover 1: ",
    prompt4: "\nEnter starting coordinates Rover 2: ",
    prompt5: "\nEnter movement commands for Rover 2: "
  }

  def run
    instructions = get_instructions
    unless instantiate_classes(instructions)
      puts ERRORS[:invalidpos]
      self.run
    end

    set_rover_positions

    unless move_n_track_rover(@rover1, instructions[2]) && move_n_track_rover(@rover2, instructions[4])
      puts ERRORS[:invalidmove]
      self.run
    end
    output_status
  end

  private

  def get_instructions
    # user will continue to be prompted until a correct instruction is received
    puts DIRECTIONS
     instructions = MESSAGES.map do |key, message|
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

  def validate_instruction(instruction, key)
    case key
    when :prompt1           then parse_coordinates(instruction)
    when :prompt2, :prompt4 then parse_rover_positions(instruction)
    when :prompt3, :prompt5 then parse_movements(instruction)
    end
  end

  def parse_coordinates(instruction)
    two_ints = /^\d{2}$/
    return false unless check_against_regex(two_ints, instruction)
    instruction.chars.map(&:to_i)
  end

  def parse_rover_positions(instruction)
    valid_position = /^\d{2}[neswNESW]{1}$/
    return false unless check_against_regex(valid_position, instruction)
    instruction.chars.each_with_index.map do |char, index|
      index == 2 ? char.upcase : char
    end
  end

  def parse_movements(instruction)
    valid_movement = /^[lrmLRM]+$/
    return false unless check_against_regex(valid_movement, instruction)
    instruction.upcase
  end

  def check_against_regex(regex, instruction)
    instruction.gsub!(/\s+/, "") unless nil
    regex.match?(instruction)
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
    return false if @rover1.x_position == @rover2.x_position && @rover1.y_position == @rover2.y_position
    true
  end

  def set_rover_positions
    @plateau.set_start_position(@rover1)
    @plateau.set_start_position(@rover2)
  end

  def move_n_track_rover(rover, instructions)
    instructions.chars.each do |instruct|
      rover.calculate_move(instruct)
      case instruct
      when "L", "R"
        rover.move
      when "M"
        if @plateau.valid_move?([rover.next_x, rover.next_y])
          @plateau.track([rover.next_x, rover.next_y], [rover.x_position, rover.y_position])
          rover.move
        else
          return false
        end
      end
    end
  end

  def output_status
    puts "\nRover 1 Final Position: #{@rover1.x_position}#{@rover1.y_position}#{@rover1.orientation}"
    puts "\nRover 2 Final Position: #{@rover2.x_position}#{@rover2.y_position}#{@rover2.orientation}"
  end
end
