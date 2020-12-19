# https://adventofcode.com/2020/day/19
using Revise
using AdventOfCode
using Test, BenchmarkTools

input = readlines("2020/data/day_19.txt")

function regexpattern(rules, id)
    rule = rules[id+1]
    occursin("\"", rule) && return rule[end-1:end-1]
    rule = split.(split(rule, "|"))
    popfirst!(rule[1])
    rx = map(x -> parse.(Int, x), rule)
    brace(x) = "("*x*")"
    f(id) = brace(regexpattern(rules, id))
    rx = map(x -> f.(x), rx)
    pattern = join(brace.(join.(rx)), "|")
    return pattern
end

function matches(regex, str) 
    m = match(regex, str)
    return (!isnothing(m)) && (m.match == str) 
end

rule_id(str) = parse(Int, first(split(str, ":")))

function part_1(input)
    s = findfirst(isempty, input)
    rules = sort(input[1:s-1]; lt=(x,y)->rule_id(x)<rule_id(y))
    messages = input[s+1:end]
    r = Regex(regexpattern(rules, 0))
    return sum(matches.(r, messages))
end
@info part_1(input)

function part_2(input)
    nothing
end
@info part_2(input)

@testset "day_19" begin
    a = split("""0: 4 1 5
    1: 2 3 | 3 2
    2: 4 4 | 5 5
    3: 4 5 | 5 4
    4: "a"
    5: "b"

    ababbb
    bababa
    abbbab
    aaabbb
    aaaabbb""", "\n")
    @test part_1(a) == 2
end
