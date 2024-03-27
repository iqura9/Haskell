read_lines_from_file(File, Lines) :-
  read_file_to_string(File, Content, []),
  split_string(Content, "\n", "", Lines).

parse_transition(Line, transition(FromState, ToState, Symbol)) :-
  split_string(Line, " ", "", [FromState, ToState, Symbol]).

generate_all_strings_helper(FiniteAutomaton, NextState, CurrentString, K) :-
  string_length(CurrentString, K),
  member(NextState, FiniteAutomaton.finalStates),
  write(CurrentString), write(' ').

generate_all_strings_helper(FiniteAutomaton, CurrentState, CurrentString, K) :-
  string_length(CurrentString, Length),
  Length < K,
  member(transition(CurrentState, NextState, Symbol), FiniteAutomaton.transitions),
  string_concat(CurrentString, Symbol, NextString),
  generate_all_strings_helper(FiniteAutomaton, NextState, NextString, K).

generate_all_strings(FiniteAutomaton, K) :-
  generate_all_strings_helper(FiniteAutomaton, FiniteAutomaton.startState, "", K),
  fail.

generate_all_strings(_, _).

main :-
  read_lines_from_file('states.txt', States),
  read_lines_from_file('symbols.txt', Symbols),
  read_lines_from_file('final_states.txt', FinalStates),
  read_lines_from_file('transitions.txt', TransitionsContent),
  read_lines_from_file('k.txt', [KContent]),

  maplist(parse_transition, TransitionsContent, Transitions),

  nth0(0, States, StartState),

  Automaton = _{states:States, symbols:Symbols, transitions:Transitions, startState:StartState, finalStates:FinalStates},

  number_string(K, KContent),

  generate_all_strings(Automaton, K).

:- initialization(main).
