printResult(Array):-
    length(Array, Length),
	Length =:= 0 -> write('');
	length(Array, Length),
    write(Array), 
    write(' Length: '), 
    write(Length), 
    nl.

isDivisible(X, Y):-
    0 is X mod Y,!.

isPrime(2):- true,!.
isPrime(X):- X < 2,!,false.
isPrime(X):-
	Limit is floor(sqrt(X)),
	\+ (between(2, Limit, Y), X \= Y, isDivisible(X, Y)).

findNextPrime(Num, Result):-
	Num1 is Num + 1,
	(isPrime(Num1) -> Result = Num1;
	findNextPrime(Num1, Result)).

subString(Array, Divider, BeforeFirst, Between, AfterLast):-
	length(Array, ArrayLength),
	FirstDivider is Divider,
	LastDivider is ArrayLength - Divider,
	split_at(FirstDivider, Array, BeforeFirst, Rest),
	RemainingLength is LastDivider - FirstDivider,
	split_at(RemainingLength, Rest, Between, AfterLast).
	
split_at(0, L, [], L).
split_at(N, [X|Xs], [X|Ys], Zs):-
	N > 0,
	N1 is N - 1,
	split_at(N1, Xs, Ys, Zs).

recursiveSubString(Array, Divider):-
	length(Array, ArrayLength),
	Divider * 2 > ArrayLength -> printResult(Array);
	subString(Array, Divider, BeforeFirst, Between, AfterLast),
	printResult(BeforeFirst),
	findNextPrime(Divider, Prime),
	recursiveSubString(Between, Prime),
	printResult(AfterLast).

run :-
	Array=[0,1,3,4,5,6,7,8,1111],
	write('input: '), 
	writeln(Array),
	write('outcome: '),nl,
	length(Array,ArrayLength),
	(ArrayLength =:= 0 -> write([]), nl;
        findNextPrime(0, Prime),
        recursiveSubString(Array, Prime)).
	