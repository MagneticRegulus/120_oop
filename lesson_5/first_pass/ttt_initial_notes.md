# Tic Tac Toe
In this assignment, we'll build a Tic Tac Toe game, just like the one we built before. This game is a little bit more complicated than Rock, Paper, Scissors, because there's the notion of a "game state", which should represent the current state of the board (the RPS game didn't have game state, only choices).

We'll take an object-oriented approach to designing the solution, so we'll employ the steps we learned earlier:

1. Write a description of the problem and extract major nouns and verbs.
2. Make an initial guess at organizing the verbs into nouns and do a spike to explore the problem with temporary code.
3. Optional - when you have a better idea of the problem, model your thoughts into CRC cards.

## Game Description
> Tic Tac Toe is a 2-player board game played on a 3x3 grid. Players take turns
marking a square. The first player to mark 3 squares in a row wins.

Nouns: board, player, square, marker
Verb: mark

(Organised)

Board (has 9 squares; has 8 winning combinations)
Square (has 0 to 1 marker)
Marker (has 1 player; has maximum of 2 instances)
Player (has 1 marker; can win, lose, or tie; has maximum of 2 instances)
- mark (places copy of marker on 1 square at a time)

## Spike
```ruby
class TTTGame
  def play
    display_welcome_message
    loop do
      display_board
      first_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end
end

class Board
  def initialize
    # we need some way to model the 3x3 grid. Maybe "squares"?
    # what data structure should we use?
    # - array/hash of Square objects?
    # - array/hash of strings or integers?
  end
end

class Square
  def initialize
    # maybe a "status" to keep track of this square's mark?
  end
end

class Player
  def initialize
    # maybe a "marker" to keep track of this player's symbol (ie, 'X' or 'O')
  end

  def mark

  end
end

# we'll kick off the game like this
game = TTTGame.new
game.play
```
