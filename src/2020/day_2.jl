# https://adventofcode.com/2020/day/2
using AdventOfCode
using Test

input = readlines("data/2020/day_2.txt")

function part_1(input)
    valid(line) = begin
        m = match(r"(\d+)-(\d+)\s(.):\s([a-zA-Z]+)", line)
        lo, hi, c, pw = parse(Int, m[1]), parse(Int, m[2]), m[3], m[4]
        lo ≤ count(c, pw) ≤ hi
    end
    count(valid, input)
end
@info part_1(input)

function part_2(input)
    valid(line) = begin
        m = match(r"(\d+)-(\d+)\s(.):\s([a-zA-Z]+)", line)
        lo, hi, c, pw = parse(Int, m[1]), parse(Int, m[2]), m[3], m[4]
        (pw[lo] == c[1]) ⊻ (pw[hi] == c[1])
    end
    count(valid, input)
end
@info part_2(input)

# unit tests
@testset "day_2" begin
    a = ["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"]
    @test part_1(a) == 2
    @test part_2(a) == 1
end
