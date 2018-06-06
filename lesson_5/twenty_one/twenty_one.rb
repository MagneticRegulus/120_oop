module Hand
  def show_hand
    puts "-----#{name}'s Hand-----"
    hand.each { |card| puts card }
    puts "Total: #{total}"
  end

  def show_first_card
    puts "-----#{name}'s Hand-----"
    puts hand.first
    puts "...and an unknown card."
    puts "Total: at least #{hand.first.value}"
  end

  def total
    card_values = []
    aces = hand.select(&:ace?)
    hand.each { |card| card_values << card.value }
    total = card_values.reduce(:+)

    aces.count.times do
      break if total <= TwentyOne::WIN_LIMIT
      total -= 10
    end

    total
  end

  def add_card(card)
    hand << card
  end

  def busted?
    total > TwentyOne::WIN_LIMIT
  end
end

class Participant
  include Hand
  attr_accessor :hand, :name

  def initialize
    @hand = []
    set_name
  end

  def to_s
    name
  end

  def >(other_player)
    total > other_player.total
  end
end

class Player < Participant
  def set_name
    answer = nil
    puts "What's your name?"
    loop do
      answer = gets.chomp.capitalize
      break unless answer.empty?
      puts "Sorry, please enter a name."
    end
    @name = answer
  end
end

class Dealer < Participant
  def set_name
    @name = self.class.to_s
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::FACES.each do |face|
        cards << Card.new(suit, face)
      end
    end

    shuffle!
  end

  def deal_one
    cards.pop
  end

  def shuffle!
    cards.shuffle!
  end
end

class Card
  COURT = %w[Jack Queen King Ace]
  SUITS = %w[Hearts Diamonds Spades Clubs]
  FACES = %w[2 3 4 5 6 7 8 9 10] + COURT

  attr_reader :suit, :face, :value

  def initialize(suit, face)
    @suit = suit
    @face = face
    @value = set_value
  end

  def set_value
    if ace?
      11
    elsif royal?
      10
    else
      face.to_i
    end
  end

  def ace?
    face == 'Ace'
  end

  def royal?
    court_member? && !ace?
  end

  def court_member?
    COURT.include?(face)
  end

  def to_s
    "The #{face} of #{suit}"
  end
end

class TwentyOne
  WIN_LIMIT = 21
  DEALER_LIMIT = 17

  attr_reader :dealer, :player, :deck

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def display_welcome
    clear_screen
    puts "Welcome to #{WIN_LIMIT}!"
    puts ""
  end

  def display_goodbye
    puts "Thanks for playing #{WIN_LIMIT}! Bye!"
  end

  def clear_screen
    system 'clear'
  end

  def shuffle_deck
    @deck = Deck.new
    player.hand = []
    dealer.hand = []
    clear_screen
  end

  def deal_cards
    2.times do
      player.add_card(deck.deal_one)
      dealer.add_card(deck.deal_one)
    end
  end

  def show_hands
    player.show_hand
    puts ""
    dealer.show_first_card
    puts ""
  end

  def player_turn
    until player.busted?
      puts "#{player}'s turn!"
      answer = nil
      puts "Would you like to (h)it or (s)tay?"
      loop do
        answer = gets.chomp.downcase
        break if %w[h hit s stay].include?(answer)
        puts "Sorry, must choose (h)it or (s)tay."
      end

      break if answer.start_with?('s')
      player.add_card(deck.deal_one)
      clear_screen
      show_hands
    end
  end

  def dealer_turn
    clear_screen
    return if player.busted?
    puts "#{dealer}'s turn!"
    until dealer.busted? || dealer.total >= DEALER_LIMIT
      puts "#{dealer} hits!"
      dealer.add_card(deck.deal_one)
    end
    puts ""
  end

  def show_result
    player.show_hand
    puts ""
    dealer.show_hand
    puts ""
    show_winner
    puts ""
  end

  def show_winner
    case winner
    when player
      puts "#{dealer} busted!" if dealer.busted?
      puts "#{player} wins!"
    when dealer
      puts "#{player} busted!" if player.busted?
      puts "#{dealer} wins!"
    else
      puts "It's a tie!"
    end
  end

  def winner
    if player.busted?
      dealer
    elsif dealer.busted?
      player
    elsif dealer > player
      dealer
    elsif player > dealer
      player
    end
  end

  def play_again?
    answer = nil
    puts "Would you like to play again? (y/n)"
    loop do
      answer = gets.chomp.downcase
      break if %w[y yes n no].include?(answer)
      puts "Sorry, must choose yes or no."
    end

    answer.start_with?('y')
  end

  def start
    display_welcome
    loop do
      deal_cards
      show_hands
      player_turn # will need to loop
      dealer_turn # will need to loop
      show_result
      break unless play_again?
      shuffle_deck
    end
    display_goodbye
  end
end

TwentyOne.new.start
