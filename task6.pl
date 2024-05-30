fruit(інжир).
fruit(іриска).
animal(їжак).
animal(їжачок).
food(індичка).
food(йогурт).
food(їжа).
other(йод).

is_fruit(X) :- fruit(X).
is_animal(X) :- animal(X).
is_food(X) :- food(X).
is_other(X) :- other(X).

is_item(X) :- is_fruit(X); is_animal(X); is_food(X); is_other(X).

describe(інжир, 'Це фрукт, який використовується в багатьох десертах.').
describe(іриска, 'Це солодощі, які відомі своїм карамельним смаком.').
describe(їжак, 'Це маленька тварина з колючками.').
describe(їжачок, 'Це ласкаве ім\'я для маленького їжака.').
describe(індичка, 'Це птах, який часто використовується як основна страва на свята.').
describe(йогурт, 'Це молочний продукт, який корисний для здоров\'я.').
describe(їжа, 'Це будь-яка речовина, яку можна вживати для харчування.').
describe(йод, 'Це хімічний елемент, який використовується як антисептик.').

ask(Question) :-
    format('~w (так/ні): ', [Question]),
    read(Response),
    (Response = так -> true; Response = ні -> fail).

determine_class(Class) :-
    (   ask('Це тварина?')
    ->  Class = animal
    ;   ask('Це фрукт?')
    ->  Class = fruit
    ;   ask('Це їжа?')
    ->  Class = food
    ;   ask('Це інше?')
    ->  Class = other
    ;   fail).

determine_object(animal, Object) :-
    (   ask('Воно має колючки?')
    ->  (Object = їжак ; Object = їжачок)
    ;   fail).
determine_object(fruit, Object) :-
    (   ask('Це десерт?')
    ->  Object = інжир
    ;   fail).
determine_object(food, Object) :-
    (   ask('Це молочний продукт?')
    ->  Object = йогурт
    ;   Object = індичка).
determine_object(other, Object) :-
    Object = йод.

instructions :-
    writeln('Ласкаво просимо до експертної системи!'),
    writeln('Ви будете відповідати на запитання системи, вводячи "так." або "ні."'),
    writeln('Система визначить тип об\'єкта, а потім задасть додаткові запитання для уточнення.'),
    writeln('Щоб почати, введіть: start.').

start :-
    (   determine_class(Class)
    ->  (   determine_object(Class, Object)
        ->  describe(Object, Description),
            format('Ваш об\'єкт: ~w. ~w~n', [Object, Description])
        ;   format('Об\'єкт не знайдено в базі знань.~n')
        )
    ;   format('Клас не знайдено в базі знань.~n')
    ).

main :-
    instructions,
    start.

:- initialization(main).