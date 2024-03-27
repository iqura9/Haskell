interface Transition {
  from: string;
  to: string;
  symbol: string;
}

class FiniteAutomaton {
  states: string[];
  symbols: string[];
  transitions: Transition[];
  startState: string;
  finalStates: string[];

  constructor(
    states: string[],
    symbols: string[],
    transitions: Transition[],
    startState: string,
    finalStates: string[]
  ) {
    this.states = states;
    this.symbols = symbols;
    this.transitions = transitions;
    this.startState = startState;
    this.finalStates = finalStates;
  }

  generateAllStringsHelper(
    currentState: string,
    currentString: string,
    allStrings: string[],
    k: number
  ) {
    if (currentString.length <= k) {
      if (
        currentString.length === k &&
        this.finalStates.includes(currentState)
      ) {
        allStrings.push(currentString);
      }

      if (currentString.length < k) {
        for (const transition of this.transitions) {
          if (transition.from === currentState) {
            const nextState = transition.to;
            const symbol = transition.symbol;
            this.generateAllStringsHelper(
              nextState,
              currentString + symbol,
              allStrings,
              k
            );
          }
        }
      }
    }
  }

  generateAllStrings(k: number) {
    const allStrings: string[] = [];
    this.generateAllStringsHelper(this.startState, "", allStrings, k);
    return allStrings;
  }
}

const states = ["q0", "q1", "q2", "q3"];

const symbols = ["a", "b", "c"];

const startState = states[0];

const transitions = [
  { from: "q0", to: "q1", symbol: symbols[0] },
  { from: "q0", to: "q2", symbol: symbols[1] },
  { from: "q0", to: "q3", symbol: symbols[2] },

  { from: "q1", to: "q0", symbol: symbols[0] },
  { from: "q1", to: "q2", symbol: symbols[1] },
  { from: "q1", to: "q3", symbol: symbols[2] },

  { from: "q2", to: "q1", symbol: symbols[0] },
  { from: "q2", to: "q0", symbol: symbols[1] },
  { from: "q2", to: "q3", symbol: symbols[2] },

  { from: "q3", to: "q3", symbol: symbols[2] },
  { from: "q3", to: "q2", symbol: symbols[1] },
  { from: "q3", to: "q1", symbol: symbols[0] },
];

const finalStates = [states[3]];

const automaton = new FiniteAutomaton(
  states,
  symbols,
  transitions,
  startState,
  finalStates
);

const k = 3;
console.log(automaton.generateAllStrings(k));
