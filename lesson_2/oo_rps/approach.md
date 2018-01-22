# Approach

The classical approach to object oriented programming is:

1. Write a textual description of the problem or exercise.
2. Extract the major nouns and verbs from the description.
3. Organize and associate the verbs with the nouns.
4. The nouns are the classes and the verbs are the behaviors or methods.

---

## Description

Rock, Paper, Scissors is a two-player game where each player chooses
one of three possible moves: rock, paper, or scissors. The chosen moves
will then be compared to see who wins, according to the following rules:

- rock beats scissors
- scissors beats paper
- paper beats rock

If the players chose the same move, then it's a tie.

## Extraction

Nouns: player, move, rule
Verbs: choose, compare

**Note:** 'Rock', 'Paper', and 'Scissors' are all variations (or instances) on
a move, hence why they are ignored in extraction.

## Organization

Player
- choose
Move
Rule


- compare

**Note:** Where should the 'compare' behavior go?

---

## Orchestration Engine

The procedural program flow should be in an egine which can orchestrate the
objects.

`RPSGame.new.play` is an easy interface to start the program. The engine,
therefore, is a class with a method to initialize the game.
