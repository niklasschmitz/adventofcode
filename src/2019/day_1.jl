# https://adventofcode.com/2019/day/1
using AdventOfCode

input = parse.(Int, readlines("data/2019/day_1.txt"))

function part_1(input)
    fuel(mass) = mass ÷ 3 - 2
    sum(fuel.(input))
end
@info part_1(input)

function part_2(input)
    fuel(mass) = begin
        f = mass ÷ 3 - 2
        f ≤ 0 ? 0 : f + fuel(f)
    end
    sum(fuel.(input))
end
@info part_2(input)
