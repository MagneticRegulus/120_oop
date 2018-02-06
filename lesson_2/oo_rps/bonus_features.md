# RPS Bonus Features

## Keeping score

Right now, the game doesn't have very much dramatic flair. It'll be more interesting if we were playing up to, say, 10 points. Whoever reaches 10 points first wins. Can you build this functionality? We have a new noun -- a score. Is that a new class, or a state of an existing class? You can explore both options and see which one works better.

> **MagneticRegulus**: it makes sense that the score is a state of a player class. This is what I have chosen to do, I have not even checked the class option.

## Add Lizard and Spock

This is a variation on the normal Rock Paper Scissors game by adding two more options - Lizard and Spock. The full explanation and rules are here: "RPSSL.gif".

> **MagneticRegulus**: The actual implementation of this was not too hard. A few general changes include computer name changes, creating better constants, figuring out how the scores would display, and a few other minor bits. I had to make a call on whether or not the choices were capitalized, and I decided to go with yes. This is mostly due to the addition of Spock.

> The bigger issue was determining how to fix the massive complexity issues raised with Rubocop for the `#>=` & `#<=` methods. I looked back at my procedural RPS game from 101. I found a hash containing the winning conditions, so I was able to gerry-rig on that. The only problem with this is that I'm not sure it is as "OO" as the list of conditionals. However, I think this code is much more flexible as it enables to add other choices and their winning conditions to one hash without having to up date the aforementioned methods.

## Add a class for each move

What would happen if we went even further and introduced 5 more classes, one for each move: Rock, Paper, Scissors, Lizard, and Spock. How would the code change? Can you make it work? After you're done, can you talk about whether this was a good design decision? What are the pros/cons?

> **MagneticRegulus**: My first approach to this is that it seems odd to change the code I currently have. Creating 5 new classes seems to be repeating yourself for the sake of doing so. I decided to write up some CRC cards to map the current state and then map out a future state which included the 5 new classes.

> I decided that the individual classes could help determine which choices beat what. However, I have so far been unsuccessful in coding this, so I will try this at some other time.

## Keep track of a history of moves

As long as the user doesn't quit, keep track of a history of moves by both the human and computer. What data structure will you reach for? Will you use a new class, or an existing class? What will the display output look like?

> **MagneticRegulus**: I used a new class called History to log each players moves in order and to also tally each players winning, losing, and tying moves. Hopefully, this will prove useful in the feature listed below. Each player has a History instance variable which is reset when the Human player decides to play again.

> I have created a `History#to_s` method which spits out a "joined" list of the logged moves for each player. I've also created `History#count_wins` and `History#count_ties` methods in order to count the number of wins and ties for each player. The number of ties should be the same for each player. I have used the latter in order to display ties when at least one has occurred. I was using the former to display wins for each player, but this proved to be unneccessary.

> Currently, the programme is only logging the moves but not using the moves for anything other than displaying the number of ties.

## Adjust computer choice based on history

Come up with some rules based on the history of moves in order for the computer to make a future move. For example, if the human tends to win over 60% of his hands when the computer chooses "rock", then decrease the likelihood of choosing "rock". You'll have to first come up with a rule (like the one in the previous sentence), then implement some analysis on history to see if the history matches that rule, then adjust the weight of each choice, and finally have the computer consider the weight of each choice when making the move. Right now, the computer has a 33% chance to make any of the 3 moves.

## Computer personalities

We have a list of robot names for our Computer class, but other than the name, there's really nothing different about each of them. It'd be interesting to explore how to build different personalities for each robot. For example, R2D2 can always choose "rock". Or, "Hal" can have a very high tendency to choose "scissors", and rarely "rock", but never "paper". You can come up with the rules or personalities for each robot. How would you approach a feature like this?

## Other bits

Remove other invalid entries for the Human player's name (name with spaces, capitalize the name?).
Include entry shortcuts for the moves (r, p, sc, l, & sp).
Review code for unused methods.
Allow for full word "yes" & "no" when asking the Human if they want to play again.
