% Name: Mary Kait Heeren
% Date: 12/3/24
% Language: Prolog
% Course: CSCI 4342 - 001
% Purpose: To create a game of our choosing using Prolog.
% This line is needed so you can modify the variables with these predicates
:- dynamic item_at/2, here/1, learned/2, score/2.

% Predicate used to say which room we are currently in
here(ballroom).

% Score and dance moves
score(player, 0).
learned(player, []).

% Series of predicates that tells us how the rooms are connected
move_to(ballroom, n, salsa_casa).
move_to(ballroom, s, tango_studio).
move_to(tango_studio, n, ballroom).
move_to(salsa_casa, e, cha_cha_chamber).
move_to(salsa_casa, s, ballroom).
move_to(cha_cha_chamber, w, salsa_casa).


% Predicates that shows which rooms the items exist in
item_at(dance_shoes, ballroom).
item_at(cha_cha_pants, cha_cha_chamber).
item_at(tango_top, tango_studio).

% Required dance moves for each room
required_dance_move(salsa_casa, cumbia_step).
required_dance_move(tango_studio, proper_frame).
required_dance_move(cha_cha_chamber, flick_step).

% Moving between rooms
go(Direction) :-
    here(CurrentLocation),
    move_to(CurrentLocation, Direction, NextLocation),
    retract(here(CurrentLocation)),
    assert(here(NextLocation)),
    look, !.

go(_) :-
    write('You cannot move in that direction.'), nl.

%the take() predicates allow us to pick up an item.
take(Item) :-
      item_at(Item, in_hand),
      write('You already have it'),
      nl, !.

take(Item) :-
      here(Place),
      item_at(Item, Place),
      retract(item_at(Item, Place)),
      assert(item_at(Item, in_hand)),
      write('OK.'),
      nl, !.
      
take(_) :-
      write('You do not see that here.'), nl.

% The describe() predicates give the room descriptions
describe(ballroom) :-
      write('You are in the Grand Ballroom'), nl,
      write('There are dance studios north and south.').

describe(salsa_casa) :-
      write('You are in the Salsa Casa'), nl,
      write('There are dance studios south and east.'), nl,
 write('You can learn the cumbia_step dance move here and perform the Salsa.').

describe(cha_cha_chamber) :-
      write('You are in the Cha Cha Chamber.'), nl,
      write('There are dance studios west.'), nl,
 write('You can learn the flick_step dance move here and perform the Cha Cha.').

describe(tango_studio) :-
      write('You are in the Tango Studio'), nl,
      write('There are dance studios north.'), nl,
 write('You can learn the proper_frame dance move and perform the Tango!').


%The look empty predicate calls a series of other predicates that will show the room descriptions and any objects
look :- here(Room),
            describe(Room),
            nl,
            show_objects(Room),
            nl.

% Predicated used to learn a dance move
learn_move(Move) :-
    here(Room),
    required_dance_move(Room, Move),
    learned(player, Moves),
    \+ member(Move, Moves),
    retract(learned(player, Moves)),
    assert(learned(player, [Move|Moves])),
    write('You learned: '), write(Move), nl, !.

learn_move(_):-
    write('That move is not taught here.'), nl.

% Predicate used to perform a dance
perform :-
    here(Room),
    required_dance_move(Room, RequiredMove),
    learned(player, Moves),
    member(RequiredMove, Moves),
    score_judges(Room), !.

perform :-
    write('You have not learned the dance move for this room.'), nl.

% Judging
score_judges(Room) :-
    Room = salsa_casa,
    write('You perfomed the Salsa! You earned an 8!'), nl,
    update_score(8);
    Room = tango_studio,
    write('You perfomed the Tango! You earned an 10!'), nl,
    update_score(10);
    Room = cha_cha_chamber,
    write('You performed the cha cha! you earned a 9!'), nl,
    update_score(9).

% Update scores
update_score(Points) :-
score(player, OldScore),
NewScore is OldScore + Points,
retract(score(player, OldScore)),
assert(score(player, NewScore)).

% Winning
win :-
    score(player, FinalScore),
    FinalScore >= 18,
    write('You have won the Mirrorball Trophy! Congrats!'), nl, !;
    write('Keep practicing and try again!'), nl.

% Show objects in room
show_objects(Room) :-
    item_at(Item, Room),
    write('The item is '), write(Item), write('.'), nl, fail.

show_objects(_).

%Help Section
help :-
    write('Dancing With The Stars Adventure Help'), nl,
    write('| start - Starts the game'), nl,
    write('| look - Describes the current room and items'), nl,
    write('| take(X) - Takes an item named X'), nl,
    write('| learn_move(X) - Learns the dance move X'), nl,
    write('| perform - Performs the required dance move for the room'), nl,
    write('| n, s, e, w - Moves in the given direction'), nl,
    write('| win - Checks if you have won the competition'), nl,
    write('| halt - Ends the game'), nl.

% Start command
start :-
    write('Welcome to the Dancing With The Stars Adventure Game!'), nl,
    help, nl, nl,
    look.