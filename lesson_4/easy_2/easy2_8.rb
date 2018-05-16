# What can we add to the Bingo class to allow it to inherit the play method from the Game class?

# Can be subclassed from Game

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game # subclassed
  def rules_of_play
    #rules of play
  end
end

weekly_bingo = Bingo.new
weekly_bingo.play
