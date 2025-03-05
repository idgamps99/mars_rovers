class Interface
  def initialize
    @errors = {
      invalidco1: "Invalid plateau coordinates",
      invalidco2: "Invalid rover coordinates",
      invalidrov1: "Invalid rover movement instrucitons"
    }
    @messages = {
      prompt1: "Enter upper right coordinates of plateau: ",
      prompt2: "Enter starting coordinates Rover 1: ",
      prompt3: "Enter movement commands for Rover 1: ",
      prompt4: "Enter starting coordinates Rover 2: ",
      prompt5: "Enter movement commands for Rover 2: "
    }
  end

  def run
    instantiate_classes(get_instruction)
    check_valid_start_positions
    enact_instructs
    # output_status
  end

  private

  def get_instruction
    # user will continue to be prompted until a correct instruction is received
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

  def validate_instruction(instruction, key)
    parse_instruction(instruction, key)
  end

  def parse_instruction(instruction, key)
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
    valid_position = /^[neswNESW]{1}\d{2}$/ # NSEW + 2 integers
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
  end

  def check_valid_start_positions
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
