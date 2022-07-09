require_relative 'lib/timegreet'
require_relative 'lib/string_methods'

# Runs the Games!
class Main
  include Timegreet
  attr_accessor :games, :current_game, :run

  def initialize
    @games = []
    load_games
    @quit = games.length + 1
    @run = true
    new_game
  end

  def select_game
    main_menu
    chosen = nil
    chosen = choice_input while chosen.nil?
    quit_game if chosen == @quit
    Object.const_get games[chosen.to_i - 1].titleize.gsub(' ', '')
  end

  def new_game
    while run
      @current_game = select_game
      current_game.new
    end
  end

  private

  def quit_game
    puts 'Thanks for playing!'
    exit
  end

  def choice_input
    puts 'Input a number to choose a game.'
    input = gets.chomp[0].to_i
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

loader = Main.new
