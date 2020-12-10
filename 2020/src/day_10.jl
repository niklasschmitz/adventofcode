# https://adventofcode.com/2020/day/10
using AdventOfCode
using Test, BenchmarkTools

input = parse.(Int, readlines("2020/data/day_10.txt"))

function part_1(input)
    sort!(input)
    diffs = input - circshift(input, 1)
    diffs[1] = input[1]
    return count(diffs .== 1) * (count(diffs .== 3) + 1)
end
@info part_1(input)

function part_2(input)
    sort!(input)
    diffs = input - circshift(input, 1)
    diffs[1] = input[1]
    total = 1
    consecutive = 0
    for i in diffs
        if i == 1
            consecutive += 1
        else  # i == 3
            total *= consecutive > 1 ? 2^(consecutive-1) : 1 # TODO FIXME
            consecutive = 0
        end
    end
    return total
end
@info part_2(input)

@testset "day_10" begin
    a = [
        16
        10
        15
        5
        1
        11
        7
        19
        6
        12
        4
    ]
    b = [
        28
        33
        18
        42
        31
        14
        46
        20
        48
        47
        24
        23
        49
        45
        19
        38
        39
        11
        1
        32
        25
        35
        8
        17
        7
        9
        4
        2
        34
        10
        3
    ]
    @test part_1(a) == 7*5
    @test part_1(b) == 22*10
    @test part_2(a) == 8
    @test part_2(b) == 19208
end

