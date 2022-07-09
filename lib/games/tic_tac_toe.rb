# Tic-Tac-Toe

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
  attr_reader :p1, :p2, :board, :current_player

  def initialize
    puts 'Welcome to Tic-Tac-Toe!'.center(80).freeze
    @p1 = Player.new(1)
    @p2 = Player.new(2)
    @board = Board.new
    puts "Have fun, #{@p1.name} (#{@p1.symbol}) and #{@p2.name} (#{@p2.symbol})!"
    play
  end

  def play
    board.display
    alternate_players
    result
  end

  def turn(player)
    square = turn_input(player)
    board.update_board(square - 1, player.symbol)
    board.display
  end

  private

  def alternate_players
    @current_player = p1
    until board.full?
      turn(current_player)
      break if board.won?

      @current_player = switch_current_player
    end
  end

  def turn_input(player)
    puts "#{player.name} it's your turn!"
    number = gets.chomp.to_i
    return number if board.legal?(number)

    puts 'Invalid input!'.red
    turn_input(player)
  end

  def switch_current_player
    if current_player == p1
      p2
    else
      p1
    end
  end

  def result
    if board.won?
      puts "Congratulations #{@current_player.name}! You won!"
    else
      puts "Well played, #{p1.name} and #{p2.name}, the game is drawn!"
    end
  end
end

# Constructs players
class Player
  attr_accessor :name, :symbol, :color, :number

  COLORS = { red: 31, green: 32, yellow: 33, blue: 34, magenta: 35, cyan: 36 }.freeze

  @@symbols= []
  @@names = []

  def initialize(number)
    @number = number
    @name = ask_name
    @color = ask_color
    @name = name.colorize(color)
    @symbol = ask_symbol[0].colorize(color)
  end

  private

  def ask_name
    puts "Player #{number}, what is your name?"
    valid?('name', @@names)
  end

  def ask_symbol
    puts "#{name}, choose a 1-character marker!"
    valid?('symbol', @@symbols)
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

  def valid?(type, list)
    empty = 'Empty input detected, try again!'.freeze
    taken = 'Sorry! '.red + "That #{type} has already been taken!"
    verified = false
    until verified
      input = gets.chomp
      puts empty if input.strip == ''
      list.include?(input.downcase) ? puts(taken) : verified = true
    end
    list << input.downcase
    input
  end
end

# Constructs TicTacToe board
class Board
  attr_accessor :grid

  # Define win conditions
  WINS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], # horizontal wins
    [0, 3, 6], [1, 4, 7], [2, 5, 8], # vertical wins
    [0, 4, 8], [2, 4, 6]             # diagonal wins
  ].freeze

  def initialize
    @grid = [*1..9]
  end

  def display
    puts <<-HEREDOC

               #{@grid[0]} | #{@grid[1]} | #{@grid[2]}
              ---+---+---
               #{@grid[3]} | #{@grid[4]} | #{@grid[5]}
              ---+---+---
               #{@grid[6]} | #{@grid[7]} | #{@grid[8]}

    HEREDOC
  end

  def update_board(square, symbol)
    @grid[square] = symbol
  end

  def legal?(square)
    grid[square - 1] == square
  end

  def full?
    grid.all? { |grid| grid =~ /[^0-9]/ }
  end

  def won?
    WINS.any? do |win|
      [grid[win[0]], grid[win[1]], grid[win[2]]].uniq.length == 1
    end
  end
end
