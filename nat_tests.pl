/* Admin */
consult([nat, lexicon]).

/* --------------- Question a) ---------------*/

/* Helper tests */
sentence([the,boy,eats]).
sentence([the,girl,sings]).


/* Yes */
% One sentence with no 'and'
conj([the, cow, chews, the, grass]).

% Two sentences separated by 'and'
conj([the, boy, eats, and, the, girl, sings]).

% Three sentences separated by 'and'
conj([the, boy, eats, and, the, girl, sings, and, the, cow, kicks]).

/* No */

% One sentence with 'and'
conj([the, boy, eats and]).
conj([the, cow, chews, the, grass,and]).

% Three sentences separated by only one 'and'
conj([the, boy, eats, and, the, girl, sings, the, cow, kicks]).


/* --------------- Question b) ---------------*/

len_char(max, R).
len_char(longerword, R).

animate_char(boy, R).
animate_char(max, R).

first_letter_char(max, R).

encode_noun(grass, R).

% X = [the,alg,chews,dlg,and,the,asb,kicks,asc]
encode([the, girl, chews, grass, and, the, boy, kicks, cow], X).


/* --------------- Question c) ---------------*/

/* Yes */
sentence_actor([the, cow, chews, the, grass], Actor).
sentence_actor([the, boy, eats, the, grass, and], Actor).


noun_phrase_actor([the, girl], Actor).

sentence_and_actor([the, boy, eats, and], Actor).

sentence_and_actor([the, girl, chews, the, grass], Actor).

same_actor_helper([the, girl, chews, the, grass], Actor).

same_actor_helper([the, girl, chews, the, grass, and, the, boy, kicks, cow], Actor).

same_actor_helper([the, girl, chews, the, grass, and, the, girl, kicks, cow], Actor).


same_actor([the, boy, chews, the, grass]).

same_actor([the, boy, chews, the, grass, and, the, boy, kicks, the, cow]).

% Test 1
sentence_and_actor([the, boy, chews, the, grass, and], Actor).
sentence_actor([the, girl, kicks, the, boy], Actor).
same_actor_helper([the, boy, chews, the, grass, and, the, girl, kicks, the, boy], Actor).



/* No */
same_actor([the, boy, chews, the, grass, and, the, girl, kicks, the, boy]).
