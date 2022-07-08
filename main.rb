require_relative 'lib/timegreet'

# Stealing from Rails
class String
  def titleize
    split(/ |\_/).map(&:capitalize).join(' ')
  end
end

#Runs the Games!
class GameSelect
  include Timegreet
  attr_accessor :games

  def initialize
    @games = []
    load_games
    @quit = games.length + 1
    select_game
  end

  def select_game
    chosen = nil
    main_menu
    chosen = choice_input while chosen.nil?
  end

  private

  def choice_input
    puts 'Input a number to choose a game.'
    begin
      input = gets.chomp[0].to_i
    rescue
      puts "Invalid selection. Enter '1-#{@quit}'!"
    end
    input if input == @quit || input - 1 <= games.length
  end

  def main_menu
    puts "\n \n#{Timegreet.say_hi} Which game would you like to play?"
    games.each_with_index { |game, idx| puts "#{idx + 1}. #{game.gsub('_', ' ').titleize}" }
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
    print "Done! \n"
    puts "Added #{File.basename(game)} to library.".rjust(80)
  end
end

main = GameSelect.new
