sortArray(Array, SortedArray):-
	sort(0, @=<, Array, SortedArray).

findSmallestN(N, Array, SmallestN):-
	sortArray(Array, SortedArray),
    findSmallestN_(N, SortedArray, SmallestN).

findSmallestN_(0, _, []).
findSmallestN_(N, [X|Xs], [X|Rest]):-
    N > 0,
    N1 is N - 1,
    findSmallestN_(N1, Xs, Rest).

findIndexes(Array1, Array2, Result):-
    findIndexesHelper(Array1, Array2, Result).

findIndexesHelper([], _, []).
findIndexesHelper([X|Xs], Array2, Result):-
    ( nth0(Index, Array2, X) -> Result = [Index|Rest],  
	  findIndexesHelper(Xs, Array2, Rest); 
      findIndexesHelper(Xs, Array2, Result) ).

getElementAtIndex(Index,[A|Rest],Result):-
	Index < 0 -> Result = -1;
	Index =:=0 -> Result = A;
	nth0(Index, [A|Rest], Result).

iterate([], _, []).
iterate([I|Is], Array, [Res|Rest]):-
    getElementAtIndex(I, Array, Res),
    iterate(Is, Array, Rest).
	
run :-
	N = 3,
	Array=[2,2,2,1],
	write('input: '), 
	writeln(Array),
	findSmallestN(N, Array, SmallestN),
	findIndexes(SmallestN,Array,Indexes),
	sortArray(Indexes,SortedIndexes),
	iterate(SortedIndexes,Array,Result),
	write('outcome: '), write(Result).
	