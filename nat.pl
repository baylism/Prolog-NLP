%%%%% Natural Language Program

sentence(S) :-
	noun_phrase(NP),
	verb_phrase(VP),
	append(NP, VP, S).

noun_phrase(NP) :-
	article(A),
	noun(N),
	append(A, N, NP).

verb_phrase(V) :-
	verb(V).

verb_phrase(VP) :-
	verb(V),
	noun_phrase(NP),
	append(V, NP, VP).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/* The required predicates and argument positions are:

	a.  conj(Text)
	b.  encode(Text, EncodedText)
	c.  same_actor(Text)

*/


/* --------------- Question a) ---------------*/

/* conj(Text)
Succeeds if text is a list of words that form two sentences separated by the
conjunction 'and'.
Assumes text is not blank.
*/

/* Approach: A conjunction of sentence consists of any number of
'sentence + and' followed by a 'sentence'. */

% Helper function succeeds on 'sentence + and'
sentence_and(Text) :-
  sentence(S1),
  append(S1, [and], Text).

% Succeed where we only have one sentence
conj(Text) :-
  sentence(Text).

% Rursive case - one 'sentence + and' followed by some text
conj(Text) :-
  sentence_and(S1),
  append(S1, Rest_of_text, Text),
  conj(Rest_of_text).

/* --------------- Question b) ---------------*/

/* encode(T, ET)
T is some text(list of words) and ET is an encoding of T such that every
noun N in T is replaced by a constant C.
*/

% Base case: empty list
encode([], []).

% Recursive case: word is a noun
encode([H|T], ET) :-
  noun([H]),
  encode_noun(H, EN),
  encode(T, R),
  append([EN], R, ET),!.

% Recursive case: word is not a noun
encode([H|T], ET) :-
  encode(T, R),
  append([H], R, ET).

% Replace a noun relevant encoding
encode_noun(N, R) :-
  animate_char(N, AC),
  len_char(N, LC),
  first_letter_char(N, FLC),
  append(AC, LC, R1),
  append(R1, FLC, RL),
  atom_chars(R, RL).

% First character of C is ‘a’ if N is animate, otherwise ‘d’.
animate_char(N, AC) :-
  animate(L),
  (member(N, L) ->
    AC = [a];
    AC = [d]).

% Second character of C is ‘l’ if N is longer than 3 letters and ‘s’ otherwise.
len_char(N, LC) :-
  atom_chars(N, L),
  length(L, Length),
  (Length > 3 ->
    LC = [l];
    LC = [s]).

% Third character of C is the first letter of N.
first_letter_char(N, TC) :-
  atom_chars(N, [H|_]),
  TC = [H].


/* --------------- Question c) ---------------*/


/* same_actor(Text)
Succeeds where all sentences in the conjunction of sentences refer to the same
actor.

*/

% Check is sentence and return actor
sentence_actor(S, Actor):-
  noun_phrase_actor(NP, Actor),
  verb_phrase(P),
  append(NP, VP, S).

% Check if noun phrase and return noun phrase actor
noun_phrase_actor(NP, Actor):-
  article(A),
  noun(N),
  Actor = N,
  append(A, N, NP).

% Helper function succeeds on 'sentence + and'
sentence_and_actor(Text, Actor) :-
  sentence_actor(S1, Actor),
  append(S1, [and], Text).

% Succeed where we only have one sentence
same_actor_helper(Text, Actor) :-
  sentence_actor(Text, Actor).

% Rursive case - one 'sentence + and' followed by some text
same_actor_helper(Text, Actor) :-
  sentence_and_actor(S1, Actor),
  same_actor_helper(Rest_of_text, Actor),
  append(S1, Rest_of_text, Text).

% Succeed on conjunction of sentences with same actor
same_actor(Text) :-
  same_actor_helper(Text, _Actor).

