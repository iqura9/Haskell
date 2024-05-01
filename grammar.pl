:- use_module(library(lists)).

grammar([
    ('S', [a]),
    ('S', [a]),
    ('S', [e]),
    ('S', [b]),
    ('S', [q]),
    ('B', [b]),
    ('B', [c]),
    ('B', ['C']),
    ('B', [a]),
    ('C', ['D']),
    ('C', [d]),
    ('D', [p])
]).

is_terminal(X) :-
    char_type(X, alnum),
    \+ char_type(X, upper).

first1(Grammar, Symbol, FirstSet) :-
    findall(Body, (member((Head, Body), Grammar), Head = Symbol), Productions),
    calculate_first1(Grammar, Productions, FirstSet).

calculate_first1(_, [], []).
calculate_first1(Grammar, [Production|Productions], FirstSet) :-
    calculate_first1(Grammar, Productions, Rest),
    calculate_first1_for_production(Grammar, Production, Rest, FirstSet1),
    union(FirstSet1, Rest, FirstSet).

calculate_first1_for_production(_, [], _, []).
calculate_first1_for_production(_, [X|_], _, [X]) :-
    is_terminal(X).
calculate_first1_for_production(Grammar, [X|Xs], Rest, FirstSet) :-
    \+ is_terminal(X),
    first1(Grammar, X, FirstX),
    subtract(FirstX, [e], FirstXWithoutE),
    (   member(e, FirstX)
    ->  calculate_first1_for_production(Grammar, Xs, Rest, RestFirstSet),
        union(FirstXWithoutE, RestFirstSet, FirstSet)
    ;   FirstSet = FirstX
    ).

show_set(Set) :-
    atomic_list_concat(Set, ', ', SetString),
    format('[~w]', [SetString]).

main :-
    grammar(G),
    non_terminals(G, NonTerminals),
    setof((NT, Set), (
        member(NT, NonTerminals),
        first1(G, NT, Set)
    ), FirstSets),
    maplist(write_first_set, FirstSets).


write_first_set((NT, Set)) :-
    format('First1(~w) = ', [NT]),
    show_set(Set),
    writeln('').

non_terminals(Grammar, NonTerminals) :-
    findall(NT, (member((NT, _), Grammar), char_type(NT, upper)), NonTerminals).

:- initialization(main).
