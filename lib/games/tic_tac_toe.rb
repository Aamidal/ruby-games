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
    puts 'Welcome to Tic-Tac-Toe!'.center(80).freeze
    Player.reset
    @p1 = Player.new
    @p2 = Player.new
    puts "Good Luck, #{p1.name} (#{p1.symbol}) and #{p2.name} (#{p2.symbol})!"
    #@board = Board.new
  end
end

# Constructs players
class Player
  attr_accessor :name, :symbol, :color

  @@player_count = 0
  @@symbols = []
  @@players = []

  COLORS = { red: 31, green: 32, yellow: 33, blue: 34, magenta: 35, cyan: 36 }.freeze

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
    input = input_verification('name', @@players)
    @@players << input.downcase
    input
  end

  def ask_symbol
    puts "#{name}, choose a 1-character marker!"
    input = input_verification('symbol', @@symbols)
    @@symbols << input.downcase
    input
  end

  def ask_color
    puts "#{name}, what's your favorite color?"
    list_colors
    choice = nil
    while choice.nil?
      input = gets.chomp[0].to_i
      input.between?(1, 6) ? choice = 30 + input : puts('Invalid input!'.red.freeze)
    end
    choice
  end

  def list_colors
    COLORS.each { |color, value| puts "#{value - 30}. " + color.to_s.colorize(value) }
  end

  def input_verification(type, list)
    empty = 'Empty input detected, try again!'.freeze
    taken = 'Sorry! '.red + "That #{type} has already been taken!"
    verified = false
    until verified
      input = gets.chomp
      puts empty if input.strip == ''
      list.include?(input.downcase) ? puts(taken) : verified = true
    end
    input
  end
end
