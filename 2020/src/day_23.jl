# https://adventofcode.com/2020/day/23
using Revise
using AdventOfCode
using Test, BenchmarkTools

input = parse.(Int, collect(readlines("2020/data/day_23.txt")[1]))

function simulate(cup; moves=100)
    # cup  : Idx   -> Label  "which cup is at I?"
    # next : Label -> Label  "which is the succ of L?"
    next = similar(cup)
    for i in 1:length(cup)
        next[cup[i]] = cup[mod1(i+1,length(cup))]
    end

    current = cup[1]
    for move in 1:moves
        # remove three next cups from circle
        c1 = next[current]
        c2 = next[c1]
        c3 = next[c2]
        next[current] = next[c3]

        # select destination
        dest = mod1(current - 1, length(cup))
        while dest in (c1,c2,c3)
            dest = mod1(dest - 1, length(cup))
        end

        # insert after destination
        next[c3] = next[dest]
        next[dest] = c1

        # advance current cup
        current = next[current]
    end
    return next
end

function part_1(input; moves=100)
    next = simulate(input; moves=moves)
    i = next[1]
    res = zeros(Int, length(input)-1)
    for j in 1:length(input)-1
        res[j] = i
        i = next[i]
    end
    return join(res) # 20 allocs
end

function part_2(input; moves=10_000_000)
    next = simulate(input; moves=moves)
    i = next[1]
    return i * next[i]
end

@testset "day_23" begin
    a = parse.(Int, collect("389125467"))
    @test part_1(a; moves=10) == "92658374"
    @test part_1(a; moves=100) == "67384529"
    @test part_2([a; collect(10:1_000_000)]) == 149245887792
end

@btime part_1(input; moves=100)
@btime part_2([input; collect(10:1_000_000)])
