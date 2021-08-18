:- module('q6',
	[sub/2]).

% Signature: sub(Sublist, List)/2
% Purpose: All elements in Sublist appear in List in the same order.
% Precondition: List is fully instantiated (queries do not include variables in their first argument).
% Example:
% ?- sub(X, [1, 2, 3]).
% X = [1, 2, 3];
% X = [1, 2];
% X = [1, 3];
% X = [2, 3];
% X = [1];
% X = [2];
% X = [3];
% X = [];
% false

sub(Sublist, List):-
   sub2(Sublist, List).

sub2([],_).
sub2([N1|R1],[N1|R2]):-
   sub2(R1,R2).
sub2([N1|R1],[_|R2]):-
   sub2([N1|R1],R2).



f(a).
