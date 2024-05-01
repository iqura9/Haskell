type Rule = { left: string; right: string[] };

class Grammar {
  rules: Rule[];

  constructor(rules: Rule[]) {
    this.rules = rules;
  }

  findFirst(symbol: string, visited: Set<string> = new Set()): Set<string> {
    const firstSet: Set<string> = new Set();

    // Перевіряємо, чи ми вже обробляли цей нетермінал
    if (visited.has(symbol)) {
      return firstSet;
    }

    // Позначаємо, що ми вже відвідали цей нетермінал
    visited.add(symbol);

    // Проходимо всі правила, що починаються з заданого нетерміналу
    for (const rule of this.rules) {
      if (rule.left === symbol) {
        const firstSymbol = rule.right[0];

        // Якщо перший символ правила - термінал, додаємо його до множини FIRST
        if (this.isTerminal(firstSymbol)) {
          firstSet.add(firstSymbol);
        }
        // Якщо перший символ правила - нетермінал, рекурсивно знаходимо його FIRST
        else {
          const firstOfFirst = this.findFirst(firstSymbol, visited);
          firstOfFirst.forEach((s) => firstSet.add(s));
        }

        // Якщо можливо, додаємо FIRST інших символів правила
        let hasEpsilon = true;
        for (let i = 1; i < rule.right.length && hasEpsilon; i++) {
          const nextSymbol = rule.right[i];

          if (this.isTerminal(nextSymbol)) {
            firstSet.add(nextSymbol);
            hasEpsilon = false;
          } else {
            const firstOfNext = this.findFirst(nextSymbol, visited);
            firstOfNext.forEach((s) => {
              if (s !== "ε") {
                firstSet.add(s);
              }
            });

            if (!firstOfNext.has("ε")) {
              hasEpsilon = false;
            }
          }
        }

        // Якщо всі символи правила можуть бути пустими, додаємо ε до FIRST
        if (hasEpsilon) {
          firstSet.add("ε");
        }
      }
    }

    return firstSet;
  }

  isTerminal(symbol: string): boolean {
    if (symbol === "ε") return true;
    // Перевіряємо, чи символ є терміналом (в даному прикладі, припускаємо, що термінали складаються з малих літер)
    return /^[a-z]$/.test(symbol);
  }
}

// Приклад використання:
const rules: Rule[] = [
  { left: "S", right: ["a", "B", "c"] },
  { left: "B", right: ["b"] },
  { left: "B", right: ["ε"] },
];

const grammar = new Grammar(rules);

console.log("FIRST(S):", grammar.findFirst("S")); // Виводимо FIRST для нетермінала S
console.log("FIRST(B):", grammar.findFirst("B")); // Виводимо FIRST для нетермінала B
