# frozen-string-literal: false

# A Game of Mastermind
class Mastermind
  def initialize
    @code = nil
    @attempts = 12
    @current_hints = []
    @all_guesses = []
    @current_guess = nil
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
    @current_guess = validate_guess(prompt_guess)
    @all_guesses << @current_guess
    feedback
  end

  def random_code
    Array.new(4) { rand(1..6) }
  end

  def prompt(text)
    print text
    gets.chomp
  end

  def prompt_guess
    prompt('What is your guess? (i.e. 1234) ')
  end

  def validate_guess(input)
    guess = input.split.map(&:to_i)
    until guess.length == 4 && guess.all? { |n| n.between?(1, 6) }
      guess = prompt('Please enter a valid sequence of 4 numbers between 1-6.')
    end
  end

  def compare(user_input)
    guess = user_input - @random_code
    [find_correct(guess), find_almost_correct(guess)]
  end

  def find_almost_correct(guess)
    4 - guess.length?
  end

  def find_correct(guess)
    @random_code.reduce(0) { |sum, n| sum + 1 if guess.include?(n) }
  end

  def feedback
    puts all_gueses
    print @current_guess + compare(@current_guess)
  end

  def game_over
    if @current_guess == @random_code
      puts "You've won after #{12 - @attempts} guesses!"
    elsif @attempts.zero?
      "You've lost!"
    end
  end
end
