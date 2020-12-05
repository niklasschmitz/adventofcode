# https://adventofcode.com/2020/day/5
using AdventOfCode
using Test, BenchmarkTools

input = readlines("2020/data/day_5.txt")

row(str) = parse(Int, replace(replace(str, 'F'=>'0'), 'B'=>'1'), base=2)
col(str) = parse(Int, replace(replace(str, 'L'=>'0'), 'R'=>'1'), base=2)
seatid(str) = row(str[1:7]) * 8 + col(str[8:10])

function part_1(input)
    maximum(seatid.(input))
end
@info part_1(input)

function part_2(input)
    ids = seatid.(input)
    sort!(ids)
    for i in 1:length(ids)-1
        if ids[i] + 1 != ids[i+1]
            return ids[i] + 1
        end
    end
end
@info part_2(input)

@testset "day_5" begin
    @testset "part_1" begin
        a = "FBFBBFFRLR"
        @test row(a[1:7]) == 44
        @test col(a[8:10]) == 5
        @test seatid(a) == 357
    end
end
