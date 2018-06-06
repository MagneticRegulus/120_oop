module Joinable
  def joinor(ary, punc=', ', conj='or')
    case ary.size
    when 1 then ary.first.to_s
    when 2 then ary.join(" #{conj} ")
    else
      "#{ary[0..-2].join(punc)}#{punc + conj} #{ary.last}"
    end
  end
end

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

  def find_winning_move(marker)
    WINNING_LINES.each do |line|
      line_markers = squares.values_at(*line).map(&:marker)
      next if line_markers.count(Square::INITIAL_MARKER) != 1
      uniq_markers = line_markers.uniq
      if uniq_markers.size == 2 && uniq_markers.include?(marker)
        line_idx = line_markers.index(Square::INITIAL_MARKER)
        return line[line_idx]
      end
    end

    nil
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
  attr_accessor :marker, :score

  def initialize(marker)
    @marker = marker
    @score = 0
  end

  def mark(board)
    board[board.unmarked_squares.sample] = marker
  end
end

class Human < Player
  include Joinable

  MARKER = 'X'

  def initialize
    super(MARKER)
  end

  def mark(board)
    avail_squares = joinor(board.unmarked_squares)
    puts "Choose an empty square (#{avail_squares}):"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_squares.include?(square)
      puts "Sorry, choose an empty square (#{avail_squares})."
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
    super(MARKER)
  end

  def mark(board)
    square = nil
    square = board.find_winning_move(MARKER) # offense
    square = board.find_winning_move(Human::MARKER) if square.nil? # defense
    square = 5 if board.unmarked_squares.include?(5) && square.nil? # pick 5
    return super if square.nil? # pick random

    board[square] = marker
  end

  def to_s
    "Computer"
  end
end

class TTTGame
  FIRST_PLAYER = 'coin toss'
  WINNING_SCORE = 5

  attr_reader :board, :human, :computer, :players,
              :current_player, :round_winner, :champion

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
    @current_player = nil
    @round_winner = nil
    @champion = nil
    @players = []
    players << human << computer
  end

  def play
    display_welcome_message
    loop do
      loop do
        set_first_player
        display_board

        loop do
          current_player_marks_board
          break if board.someone_won? || board.full?
          clear_and_display_board if human_turn?
        end

        find_winner_and_update_score
        break if champion?

        display_result
        break unless next_round?

        reset_round
      end

      display_champion_result
      break unless play_again?

      reset_game
      display_play_again_message
    end
    display_goodbye_message
  end

  private

  def set_first_player
    case FIRST_PLAYER
    when 'human' then @current_player = human
    when 'computer' then @current_player = computer
    when 'coin toss' then @current_player = players.sample
    end

    puts "First Player: #{current_player}."
    if current_player == computer
      loop do
        puts "Press enter to begin."
        break if gets.chomp.empty?
      end
    end
  end

  def screen_clear
    system 'clear'
  end

  def display_welcome_message
    screen_clear
    puts "Welcome to Tic Tac Toe!"
    puts "The first player to win #{WINNING_SCORE} games is the champion!"
    puts ''
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_play_again_message
    puts "Let's play again!"
  end

  def display_board
    puts "You're #{human.marker}. Computer is #{computer.marker}."
    display_scores
    board.display
    puts ''
  end

  def clear_and_display_board
    screen_clear
    display_board
  end

  def display_scores
    puts ''
    puts "-----SCOREBOARD-----"
    puts "#{human}: #{human.score}. #{computer}: #{computer.score}."
    puts ''
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

  def find_winner_and_update_score
    case board.winning_marker
    when Human::MARKER
      @round_winner = human
      human.score += 1
      @champion = human if human.score >= 5
    when Computer::MARKER
      @round_winner = computer
      computer.score += 1
      @champion = computer if computer.score >= 5
    else
      return
    end
  end

  def champion?
    !!champion
  end

  def display_result
    clear_and_display_board
    if round_winner
      puts "#{round_winner} won the round!"
    else
      puts "It's a tie!"
    end
  end

  def display_champion_result
    display_result
    display_scores
    puts "#{champion} is the champion!" unless !champion
  end

  def next_round?
    answer = nil

    loop do
      puts "Continue to next round? (y/n)"
      answer = gets.chomp.downcase
      break if %w[y yes n no].include?(answer)
      puts "Sorry, must be y or n."
    end

    answer.start_with?('y')
  end

  def play_again?
    answer = nil

    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w[y yes n no].include?(answer)
      puts "Sorry, must be y or n."
    end

    answer.start_with?('y')
  end

  def reset_round
    @board = Board.new
    @round_winner = nil
    screen_clear
  end

  def reset_game
    @champion = nil
    human.score = 0
    computer.score = 0
    reset_round
  end
end

game = TTTGame.new
game.play
