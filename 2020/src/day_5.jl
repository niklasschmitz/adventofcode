# https://adventofcode.com/2020/day/5
using AdventOfCode
using Test, BenchmarkTools

input = readlines("2020/data/day_5.txt")

seatid(str) = parse(Int, map(c-> (c=='B'||c=='R') ? '1' : '0', str), base=2)

function part_1(input)
    maximum(seatid.(input))
end
@info part_1(input)

function part_2(input)
    ids = seatid.(input)
    min_id = minimum(ids)
    bits = trues(maximum(ids) - min_id + 1)
    for id in ids
        bits[id - min_id + 1] = false
    end
    findfirst(bits) + min_id - 1
end
@info part_2(input)

@testset "day_5" begin
    @testset "part_1" begin
        a = "FBFBBFFRLR"
        @test seatid(a) == 357
    end
end

@btime part_1($input)
@btime part_2($input)
