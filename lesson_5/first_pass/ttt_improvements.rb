class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diags

  attr_reader :squares

  def initialize
    @squares = {}
    (1..9).each { |sq| @squares[sq] = Square.new }
  end

  def []=(sq, marker)
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
  def winning_marker
    WINNING_LINES.each do |line|
      line_markers = squares.values_at(*line).map(&:marker)
      next if line_markers.include?(Square::INITIAL_MARKER)
      return line_markers.first if line_markers.uniq.size == 1
    end

    nil
  end

  def someone_won?
    !!winning_marker
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

  def display
    display_board_end
    display_squares_at(1, 2, 3)
    display_board_crosses
    display_squares_at(4, 5, 6)
    display_board_crosses
    display_squares_at(7, 8, 9)
    display_board_end
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
    board[board.unmarked_squares.sample] = marker
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

    board[square] = marker
  end

  def to_s
    "You"
  end
end

class Computer < Player
  MARKER = 'O'

  def initialize
    @marker = MARKER
  end

  def to_s
    "Computer"
  end
end

class TTTGame
  attr_reader :board, :human, :computer, :current_player

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
    @current_player = human
  end

  def play
    display_welcome_message
    loop do
      set_first_player
      display_board
      loop do
        current_player_marks_board
        break if board.someone_won? || board.full?
        clear_and_display_board if human_turn?
      end
      display_result
      break unless play_again?
      reset
      display_play_again_message
    end
    display_goodbye_message
  end

  private

  def set_first_player
    @current_player = human
    puts "First Player: #{current_player}."
  end

  def screen_clear
    system 'clear'
  end

  def display_welcome_message
    screen_clear
    puts "Welcome to Tic Tac Toe!"
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_play_again_message
    puts "Let's play again!"
  end

  def display_board
    puts "You're #{human.marker}. Computer is #{computer.marker}."
    puts ''
    board.display
    puts ''
  end

  def clear_and_display_board
    screen_clear
    display_board
  end

  def current_player_marks_board
    current_player.mark(board)
    switch_to_next_player
  end

  def switch_to_next_player
    case current_player
    when human then @current_player = computer
    when computer then @current_player = human
    end
  end

  def human_turn?
    current_player == human
  end

  def display_result
    clear_and_display_board
    case board.winning_marker
    when Human::MARKER    then puts "#{human} won!"
    when Computer::MARKER then puts "#{computer} won!"
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

  def reset
    @board = Board.new
    set_first_player
    screen_clear
  end
end

# we'll kick off the game like this
game = TTTGame.new
game.play
