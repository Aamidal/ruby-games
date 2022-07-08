require_relative 'lib/timegreet'

#Runs the Games!
class GameLoader
  include Timegreet
  attr_accessor :games

  def initialize
    @games = []
    load_games
    @players = []
  end

  private

  def load_games
    Dir.glob('./lib/games/*.rb').sort.each do |rb_game|
      require_relative rb_game
      @games << File.basename(rb_game)
      add_game(rb_game)
    end
  end

  def output_load(game)
    print "Reading #{game}"
    3.times do
      sleep 0.5
      print '.'
    end
    print "Done! \n"
    puts "Added #{File.basename(game)} to library."
  end
end

main = GameLoader.new
puts main.games
