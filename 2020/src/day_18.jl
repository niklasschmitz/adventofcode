# https://adventofcode.com/2020/day/18
using AdventOfCode
using Test, BenchmarkTools

input = readlines("2020/data/day_18.txt")

⊗(x,y) = x + y
⊕(x,y) = x * y
eval1(line) = replace(line, "+"=>"⊗") |> Meta.parse |> eval
eval2(line) = replace(replace(line, "+"=>"⊗"), "*"=>"⊕") |> Meta.parse |> eval
part_1(input) = sum(eval1.(input))
part_2(input) = sum(eval2.(input))
@info part_1(input)
@info part_2(input)

@testset "day_18" begin
    @test eval1("1 + 2 * 3 + 4 * 5 + 6") == 71
    @test eval1("1 + (2 * 3) + (4 * (5 + 6))") == 51
    @test eval2("1 + (2 * 3) + (4 * (5 + 6))") == 51
    @test eval2("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2") == 23340
end

Base.operator_precedence(:+)
Base.operator_precedence(:*)
Base.operator_precedence(:⊗)
Base.operator_precedence(:⊕)
