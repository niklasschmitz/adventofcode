# https://adventofcode.com/2020/day/15
using AdventOfCode
using Test, BenchmarkTools
using DataStructures

input = parse.(Int, split(readlines("2020/data/day_15.txt")[1], ","))

function part_1(input; until=2020)
    spoken = Dict(i => push!(CircularBuffer(2), idx) for (i,idx) in zip(input, eachindex(input)))
    n = input[end]
    isnew = true
    for i in length(input)+1:until
        n = isnew ? 0 : spoken[n][end] - spoken[n][end-1]
        if !(n in keys(spoken))
            spoken[n] = CircularBuffer(2)
        end
        push!(spoken[n], i)
        isnew = length(spoken[n]) < 2
    end
    return n
end
@info part_1(input)

function part_2(input)
    return part_1(input, until=30_000_000)
end
@info part_2(input)

@testset "day_15" begin
    @testset "part_1" begin
        @test part_1([0,3,6]) == 436
        @test part_1([1,3,2]) == 1
        @test part_1([2,1,3]) == 10
        @test part_1([1,2,3]) == 27
    end
    @testset "part_2" begin
        @test part_2([0,3,6]) == 175594
        @test part_2([1,3,2]) == 2578
        @test part_2([2,1,3]) == 3544142
        @test part_2([1,2,3]) == 261214
    end
end
