require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diags

  attr_reader :squares

  def initialize
    @squares = {}
    (1..9).each { |sq| @squares[sq] = Square.new }
  end

  def get_mark_at(sq)
    squares[sq].marker
  end

  def set_square_at(sq, marker)
    squares[sq].marker = marker
  end

  def square_empty?(sq)
    squares[sq].unmarked?
  end

  def unmarked_squares
    squares.keys.select { |sq| square_empty?(sq) }
  end

  def full?
    unmarked_squares.empty?
  end

  # returns winning marker or nil
  def detect_winner
    winning_marker = nil

    WINNING_LINES.each do |line|
      line_markers = squares.values_at(*line).map(&:marker)
      next if line_markers.include?(Square::INITIAL_MARKER)
      line_markers.uniq!
      winning_marker = line_markers[0] if line_markers.size == 1
      break if !!winning_marker
    end

    winning_marker
  end

  def someone_won?
    !!detect_winner
  end

  def display_board_end
    puts "     |     |"
  end

  def display_board_crosses
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
  end

  def display_squares_at(lft, mid, rt)
    puts "  #{squares[lft]}  |  #{squares[mid]}  |  #{squares[rt]}"
  end

  def display(clear=true)
    system 'clear' if clear
    puts "You're #{Human::MARKER}. Computer is #{Computer::MARKER}."
    puts ""
    display_board_end
    display_squares_at(1, 2, 3)
    display_board_crosses
    display_squares_at(4, 5, 6)
    display_board_crosses
    display_squares_at(7, 8, 9)
    display_board_end
    puts ""
  end
end

class Square
  INITIAL_MARKER = ' '
  attr_accessor :marker

  def initialize
    @marker = INITIAL_MARKER
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def mark(board)
    board.set_square_at(board.unmarked_squares.sample, marker)
  end
end

class Human < Player
  MARKER = 'X'

  def initialize
    @marker = MARKER
  end

  def mark(board)
    puts "Choose an empty square (numbered #{board.unmarked_squares.join(', ')}):"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_squares.include?(square)
      puts "Sorry, choose an empty square (numbered #{board.unmarked_squares.join(', ')})."
    end

    board.set_square_at(square, marker)
  end
end

class Computer < Player
  MARKER = 'O'

  def initialize
    @marker = MARKER
  end
end

class TTTGame
  attr_reader :board, :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    system 'clear'
    puts "Welcome to Tic Tac Toe!"
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_result
    board.display
    case board.detect_winner
    when Human::MARKER    then puts "You won!"
    when Computer::MARKER then puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil

    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y yes n no).include?(answer)
      puts "Sorry, must be y or n."
    end

    answer.start_with?('y')
  end

  def play
    display_welcome_message
    loop do
      @board = Board.new
      board.display(false)
      loop do
        human.mark(board)
        break if board.someone_won? || board.full?

        computer.mark(board)
        break if board.someone_won? || board.full?

        board.display
      end
      display_result
      break unless play_again?
      system 'clear'
      puts "Let's play again!"
    end
    display_goodbye_message
  end
end

# we'll kick off the game like this
game = TTTGame.new
game.play
