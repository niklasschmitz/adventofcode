# https://adventofcode.com/2020/day/9
using AdventOfCode
using Test, BenchmarkTools

input = parse.(Int, readlines("2020/data/day_9.txt"))

function part_1(input; preamble=25)
    pre = @view input[1:preamble]
    pairs = pre .+ pre'
    for i in preamble+1:length(input)
        oldval = input[i-preamble]
        val = input[i]
        !(val in pairs) && return val
        idx = ((i - 1) % preamble) + 1
        pairs[idx,:] .+= val - oldval
        pairs[:,idx] .+= val - oldval
        pairs[idx,idx] -= val - oldval
    end
    return -1
end
@info part_1(input)

""" Approach 1: quadratic time brute-force"""
function part_2(input; sumto=257342611)
    for i in 1:length(input)
        s = input[i]
        lo = s
        hi = s
        for j in i+1:length(input)
            s += input[j]
            lo = min(lo, input[j])
            hi = max(hi, input[j])
            (s == sumto) && return hi + lo
        end
    end
    return -1
end
@info part_2(input)


@testset "day_9" begin
    a = split("""35
    20
    15
    25
    47
    40
    62
    55
    65
    95
    102
    117
    150
    182
    127
    219
    299
    277
    309
    576""", "\n")
    a = parse.(Int, a)
    @test part_1(a, preamble=5) == 127
    @test part_2(a, sumto=127) == 62
end
