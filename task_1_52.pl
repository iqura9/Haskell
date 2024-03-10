:- dynamic isNotDivisible/2.
:- dynamic isPrime/1.

isDivisible(X, Y) :-
    0 is X mod Y,!.

isPrime(2) :- true,!.
isPrime(X) :- X < 2,!,false.
isPrime(X) :-
	Limit is floor(sqrt(X)),
	\+ (between(2, Limit, Y), X \= Y, isDivisible(X, Y)).

keepPrimes(Array, Primes) :-
	keepPrimes(Array, 0, Primes).
	
keepPrimes([], _, []).
keepPrimes([H|T], Index, Primes) :-
	isPrime(Index),
	NextIndex is Index + 1,
	keepPrimes(T, NextIndex, Primes1),
	Primes = [H|Primes1].
keepPrimes([_|T], Index, Primes) :-
	NextIndex is Index + 1,
	keepPrimes(T, NextIndex, Primes).
	
run :-
	Array=[0, 1],
	write('input: '), 
	writeln(Array),
	keepPrimes(Array, Primes),
	write('outcome: '), write(Primes).
	