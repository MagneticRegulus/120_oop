# OO Rock, Paper, Scissors

module Joinable
  def joinor(ary, punc, conj='')
    ary[0..-2].join(punc) + punc + conj + ' ' + ary.last
  end
end

class RPSGame
  WIN_SCORE = 10

  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to #{Move::CHOICES.join(', ')}!"
  end

  def display_goodbye_message
    puts 'Thanks for playing. Good-bye!'
  end

  def display_moves
    system 'clear'
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      human.win
    elsif human.move < computer.move
      computer.win
    else
      puts "It's a tie!"
    end
  end

  def display_scores
    puts "#{'=' * 5}Scoreboard#{'=' * 5}"
    puts "#{human.name}: #{human.score} pts."
    puts "#{computer.name}: #{computer.score} pts."
    puts '=' * 20
  end

  def champion?
    human.score >= WIN_SCORE || computer.score >= WIN_SCORE
  end

  def display_champion
    if champion?
      champ = (human.score >= WIN_SCORE ? human : computer)
      puts "#{champ.name} is the champion!"
    else
      puts "Must have #{WIN_SCORE} points to win!"
    end
  end

  def play_again?
    answer = nil

    loop do
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp
      break if %w[y n].include?(answer.downcase)
      puts 'Invalid answer. Please choose y or n.'
    end

    answer.downcase == 'y'
  end

  def clear_scores
    human.score = 0
    computer.score = 0
  end

  def play
    display_welcome_message

    loop do
      loop do
        human.choose
        computer.choose
        display_moves
        display_winner
        display_scores
        display_champion
        break if champion?
      end
      break unless play_again?
      clear_scores
    end

    display_goodbye_message
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end

  def win
    @score += 1
    puts "#{name} won!"
  end
end

class Human < Player
  include Joinable

  def set_name
    answer = nil
    loop do
      puts "What's your name?"
      answer = gets.chomp
      break unless answer.empty?
      puts 'Sorry, you must enter a name.'
    end
    self.name = answer
  end

  def choose
    choice = nil
    loop do
      puts "Please choose #{joinor(Move::CHOICES, ', ', 'or')}:"
      choice = gets.chomp.capitalize
      break if Move::CHOICES.include?(choice)
      puts 'Invalid choice.'
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  ROBOTS = ['R2D2', 'HAL 9000', 'Bender', 'Rosie', 'Tom Servo', 'GLaDOS']

  def set_name
    self.name = ROBOTS.sample
  end

  def choose
    self.move = Move.new(Move::CHOICES.sample)
  end
end

class Move
  WIN_CONDITIONS = {
    'Rock' => %w[Scissors Lizard],
    'Paper' => %w[Rock Spock],
    'Scissors' => %w[Paper Lizard],
    'Lizard' => %w[Paper Spock],
    'Spock' => %w[Rock Scissors]
  }

  CHOICES = WIN_CONDITIONS.keys

  def initialize(choice)
    @move = choice
  end

  def >(other_move)
    WIN_CONDITIONS[@move].include?(other_move.to_s)
  end

  def <(other_move)
    WIN_CONDITIONS[other_move.to_s].include?(@move)
  end

  def to_s
    @move
  end
end

RPSGame.new.play
