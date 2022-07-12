require_relative 'lib/timegreet'
require_relative 'lib/string_methods'

# Runs the Games!
class Main
  include Timegreet
  attr_accessor :games, :current_game, :run

  def initialize
    @games = []
    load_games
    @run = true
    @quit = games.length + 1
    new_game
  end

  def new_game
    select_game while run
  end

  def select_game
    main_menu
    chosen = nil
    chosen = choice_input while chosen.nil?
    quit_game if chosen == @quit
    chosen = Object.const_get games[chosen - 1].titleize.gsub(' ', '')
    start_game(chosen)
  end

  def start_game(game)
    @current_game = game
    current_game.new
  end

  private

  def prompt(question)
    print question
    gets
  end

  def quit_game
    @run = false
    puts 'Thanks for playing!'
    exit
  end

  def choice_input
    input = prompt("Input the game's number:").chomp.to_i
    return input if input == @quit || input.between?(1, games.length)

    nil
  end

  def main_menu
    puts "\n \n#{Timegreet.say_hi} Which game would you like to play?"
    games.each_with_index { |game, idx| puts "#{idx + 1}. #{game.titleize}" }
    puts "#{@quit}. Quit \n"
  end

  def load_games
    Dir.glob('./lib/games/*.rb').sort.each do |rb_game|
      require_relative rb_game
      @games << File.basename(rb_game, File.extname(rb_game))
      output_load(rb_game)
    end
    puts "Loaded #{games.length} games:"
    puts games.join(', ').center(80)
  end

  def output_load(game)
    print "Reading #{game}"
    3.times do
      sleep 0.5
      print '.'
    end
    print "Done! \n".green
    puts "Added #{File.basename(game)} to library.".rjust(80)
  end
end

Main.new
