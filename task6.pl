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

get_description(Item, Description) :- describe(Item, Description).

get_hint(Item, Hint) :-
    is_fruit(Item), Hint = 'Це фрукт.' ;
    is_animal(Item), Hint = 'Це тварина.' ;
    is_food(Item), Hint = 'Це їжа.' ;
    is_other(Item), Hint = 'Це інше.'.

% get_hint(інжир, Hint).
% get_description(інжир, Description).
