# https://adventofcode.com/2020/day/18
using AdventOfCode
using Test, BenchmarkTools

input = readlines("2020/data/day_18.txt")

# in r replace s by t
_replace(r, s, t) = r
_replace(r::Symbol, s::Symbol, t::Symbol) = r == s ? t : r
function _replace(expr::Expr, s::Symbol, t::Symbol)
    expr = copy(expr)
    expr.head = _replace(expr.head, s, t)
    expr.args .= _replace.(expr.args, s, t)
    return expr
end

function evaluate1(line)
    expr = Meta.parse(replace(line, "*" => "-"))  # avoid *+ precedence, but parse parens
    expr = _replace(expr, :-, :*)
    return eval(expr)
end

function evaluate2(line)
    expr = Meta.parse(replace(line, "*" => "|>"))
    expr = _replace(expr, :(|>), :*)
    return eval(expr)
end

part_1(input) = sum(evaluate1.(input))
part_2(input) = sum(evaluate2.(input))

@info part_1(input)
@info part_2(input)

@testset "day_18" begin
    @test evaluate1("1 + 2 * 3 + 4 * 5 + 6") == 71
    @test evaluate1("1 + (2 * 3) + (4 * (5 + 6))") == 51
    @test evaluate2("1 + (2 * 3) + (4 * (5 + 6))") == 51
    @test evaluate2("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2") == 23340
end
