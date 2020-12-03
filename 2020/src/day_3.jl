# https://adventofcode.com/2020/day/3
using AdventOfCode
using Test, BenchmarkTools

input = readlines("2020/data/day_3.txt")

function part_1(input)
    width = length(input[1])
    numtrees = 0
    y = 0
    for line in @view input[2:end]
        y += 3
        idx = (y % width) + 1
        if line[idx] == '#'
            numtrees += 1
        end
    end
    return numtrees
end
@info part_1(input)

function part_2(input)
    nothing
end
@info part_2(input)

@testset "day_3" begin
    a = """..##.......
    #...#...#..
    .#....#..#.
    ..#.#...#.#
    .#...##..#.
    ..#.##.....
    .#.#.#....#
    .#........#
    #.##...#...
    #...##....#
    .#..#...#.#    
    """
    a = split(a)
    @test part_1(a) == 7
end
