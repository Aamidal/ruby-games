# frozen-string-literal: false

# A Game of Mastermind
class Mastermind
  def initialize
    @code = nil
    @attempts = 12
    @current_hints = []
    @history = []
    run
  end

  def run
    @code = random_code
    p @code
    game_loop until @current_guess == @code || @attempts.zero?
    results
  end

  def game_loop
    @attempts -= 1
    @history.push validate_guess(prompt_guess)
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

  def compare(current_guess)
    difference = current_guess - @code
    [find_correct(difference), find_almost_correct(difference)]
  end

  def find_almost_correct(guess)
    4 - guess.length
  end

  def find_correct(guess)
    @code.reduce(0) { |sum, n| sum + 1 if guess.include?(n) }
  end

  def feedback
    puts "History: #{@history}"
    puts "Difference #{compare(@history[-1])}"
  end

  def game_over
    if @current_guess == @random_code
      puts "You've won after #{12 - @attempts} guesses!"
    elsif @attempts.zero?
      "You've lost!"
    end
  end
end

Mastermind.new