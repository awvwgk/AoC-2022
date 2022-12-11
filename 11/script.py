import sys
import math
from copy import deepcopy
from functools import reduce
from typing import Any, Dict, List


def solve(monkeys: List[Dict[Any, Any]], repeat: int, divide: int) -> int:

    lcm = math.lcm(*[monkey["test"] for monkey in monkeys])

    for _ in range(repeat):
        for monkey in monkeys:
            items, monkey["items"] = monkey["items"], []
            monkey["inspections"] += len(items)

            for item in items:
                score = monkey["operation"](item) // divide % lcm
                target = monkey[score % monkey["test"] == 0]
                monkeys[target]["items"].append(score)

    return reduce(
        (lambda x, y: x * y),
        sorted([monkey["inspections"] for monkey in monkeys])[-2:],
    )


def main(args: List[str]) -> None:
    with open(args[0], "r", encoding="utf-8") as fd:
        lines = [block.split("\n") for block in fd.read().split("\n\n")]

    monkeys = [
        {
            "items": [int(item) for item in block[1].split(": ")[-1].split(", ")],
            "operation": eval("lambda old: " + block[2].split("new = ")[-1]),
            "test": int(block[3].split()[-1]),
            True: int(block[4].split()[-1]),
            False: int(block[5].split()[-1]),
            "inspections": 0,
        }
        for block in lines
    ]

    print(f"Part 1: {solve(deepcopy(monkeys), repeat=20, divide=3)}")
    print(f"Part 2: {solve(deepcopy(monkeys), repeat=10000, divide=1)}")


if __name__ == "__main__":
    main(sys.argv[1:])
