# # Tic-Tac-Toe

# ### Objective
# Build a functional tic-tac-toe game using OOP design which runs in the console.

# ### Project Goals
# - Explore object-oriented design
# - Try to encapsulate code as much as reasonably possible
# - Develop reusable framework for for running simple games to handle general logic 
#   (main menu, quit, loop until game over, etc)
#   - Can this become a shell to run the curriculum's future games from? 
#     Mastermind, Chess, etc.
# - Explore console output formatting options. Colored text, centered gameboard, 
#   etc.

# ### Procedure
#   1. Initialize a new game board and players <br>
#     - Initialized gameboard displays 1-9 in place of player symbols
#   2. Establish player names and their chosen symbols
#   3. Alternate turns between players <br>
#     - Display board between turns <br>
#     - Print Player# turn <br>
#     - Get Player move input - input an unchosen square, return error and repeat
#       if square invalid <br>
#     - Valid player input replaces that square's value with player symbol <br>
#   4. Check for win condition, or filled board <br>
#     - if Won, print win message with winning player<br>
#     - if Filled board, print draw message
#   5. Offer choice to play again

# A Fresh Game of Tic-Tac-Toe
class TicTacToe
  attr_reader :p1, :p2
    
  def initialize
    puts 'Welcome to Tic-Tac-Toe!'.center(80)
    Player.reset
    @p1 = Player.new
    @p2 = Player.new
    puts "Good Luck, #{p1.name} (#{p1.symbol}) and #{p2.name} (#{p2.symbol})!"
    #@board = Board.new
  end

end

class Player
  attr_accessor :name, :symbol, :color
  @@player_count = 0
  @@symbols = []
  @@players = []

  COLORS = { red: 31, green: 32, yellow: 33, blue: 34, magenta: 35, cyan: 36 }

  def initialize
    @@player_count += 1
    @name = ask_name
    @color = ask_color
    @name = name.colorize(color)
    @symbol = ask_symbol[0].colorize(color)
  end

  def self.reset
    @@player_count = 0
    @@symbols = []
    @@players = []
  end

  private
  
  def ask_name
    puts "Player #{@@player_count}, what is your name?"
    input = input_verification('name')
    @@players << input.downcase
    input
  end

  def ask_symbol
    puts "#{name}, choose a 1-character marker!"
    input = input_verification('symbol')
    @@symbols << input.downcase
    input
  end

  def ask_color
    puts "#{name}, what's your favorite color?"
    COLORS.each { |color, value| puts "#{value - 30}. " + "#{color}".colorize(value) }
    color_value = nil
    while color.nil?
      input = gets.chomp.to_i
      if input.between?(1, 6)
        return color_value = 30 + input
      else
        puts('Sorry! '.red + "#{input} is an invalid input!")
      end
    end
  end

  def input_verification(type)
    empty = "Empty input detected, try again!"
    taken = 'Sorry! '.red + "That #{type} has already been taken!"
    verified = false
    until verified
      input = gets.chomp
      puts empty if input.strip == ''
      case type
      when 'name'
        @@players.include?(input.downcase) ? puts(taken) : verified = true
      when 'symbol'
        @@symbols.include?(input.downcase) ? puts(taken) : verified = true
      else
        puts "Unknown case error!".red
      end
    end
    input
  end
end
