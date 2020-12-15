# https://adventofcode.com/2020/day/15
using AdventOfCode
using Test, BenchmarkTools

input = parse.(Int, split(readlines("2020/data/day_15.txt")[1], ","))

function part_1(input; until=2020)
    spoken = Dict(i => [idx] for (i,idx) in zip(input, eachindex(input)))
    n = input[end]
    isnew = true
    for i in length(input)+1:until
        print("$i ")
        if isnew
            n = 0
        else
            n = spoken[n][end] - spoken[n][end-1]
        end
        if !(n in keys(spoken))
            spoken[n] = Int[]
        end
        push!(spoken[n], i)
        isnew = length(spoken[n]) < 2
    end
    return n
end
@info part_1(input)

function part_2(input)
    nothing
end
@info part_2(input)

@testset "day_15" begin
    a = [0, 3, 6]
    @test part_1(a) == 436
    @test part_2(a) == 175594
    @test part_2([1,3,2]) == 175594
    @test part_2([2,1,3]) == 175594
    @test part_2([1,2,3]) == 175594
end
