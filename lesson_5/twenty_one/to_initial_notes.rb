=begin
Twenty-One is a card game consisting of a dealer and a player, where the participants try to get as close to 21 as possible without going over.

Here is an overview of the game:
- Both participants are initially dealt 2 cards from a 52-card deck.
- The player takes the first turn, and can "hit" or "stay".
- If the player busts, he loses. If he stays, it's the dealer's turn.
- The dealer must hit until his cards add up to at least 17.
- If he busts, the player wins. If both player and dealer stays, then the highest total wins.
- If both totals are equal, then it's a tie, and nobody wins.

Nouns: card, player, dealer, deck, game, hand
Verbs: deal, hit, stay, bust

Player
- hit
- stay
- busted?
- total

Dealer
- hit
- stay
- busted?
- total
- deal (here or in Deck?)

Deck
- deal (here or in Dealer?)

Card (part of the deck?)

Game
- start

There is a redundancy between Player and Dealer. Should these be sub-classes? Or should they include a "Hand" module?
=end
