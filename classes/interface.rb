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
    get_instruction
    # create_plateau
    # create_rover
    # move_rover
    # track_rover
    # output_status
  end

  private

  def get_instruction
     instructions = @messages.map do |key, message|
      loop do
        break if validate_instruction(prompt(message), key)
      end
    end
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
    return false unless intruction.length == 2
    return false unless instruction.is_a?(Integer)
    instructions.chars.map do |int|
      int.to_i
    end
  end

  def parse_rover_positions(instruction)
  end

  def parse_movements(instruction)
  end

  def create_rover
  end

  def create_plateau
  end

  def move_rover
  end

  def track_rover
  end

  def output_status
  end
end
