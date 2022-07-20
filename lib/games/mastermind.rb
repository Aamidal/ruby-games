# frozen-string-literal: false

# A Game of Mastermind
class Mastermind
  def initialize
    @code = nil
    @attempts = 12
    @current_hints = []
    @history = []
    @current_guess = nil
    run
  end

  def run
    @code = random_code
    p @code
    game_loop until @current_guess == @code || @attempts.zero?
    game_over
  end

  def game_loop
    @attempts -= 1
    @history.push validate_guess(prompt_guess)
    @current_guess = @history[-1]
    feedback
  end

  def random_code
    Array.new(4) { rand(1..6) }
  end

  def prompt(text)
    print text
    gets.chomp.split('').map(&:to_i)
  end

  def prompt_guess
    prompt('What is your guess? (i.e. 1234) ')
  end

  def validate_guess(guess)
    until guess.length == 4 && guess.all? { |n| n.between?(1, 6) }
      guess = prompt('Please enter a valid sequence of 4 numbers between 1-6.')
    end
    guess
  end

  def feedback
    diff = @current_guess.map.with_index { |x, i| x == @code[i] }
    puts "Previous Guesses: #{@history}"
    print "Current Guess: #{@current_guess.join('')} "
    puts "Correct: #{find_correct(diff)} Almost: #{find_almost(diff)}"
    puts "Tries remaining: #{@attempts}"
  end

  def find_correct(diff)
    diff.count true
  end

  def find_almost(diff)
    incorrect = diff.each_index.reject { |i| diff[i] }
    incorrect.reduce(0) { |sum, i| @code.include?(@current_guess[i]) ? sum + 1 : sum }
  end

  def game_over
    if @current_guess == @code
      puts "You've won after #{12 - @attempts} guesses!"
    elsif @attempts.zero?
      puts "You've lost!"
    end
  end
end

# Mastermind.new
