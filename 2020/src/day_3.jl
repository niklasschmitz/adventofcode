# https://adventofcode.com/2020/day/3
using AdventOfCode
using Test, BenchmarkTools

input = readlines("2020/data/day_3.txt")

function count_trees_on_slope(input; right=1, down=1)
    width = length(input[1])
    numtrees = 0
    y = -right
    for line in @view input[1:down:end]
        y += right
        idx = (y % width) + 1
        if line[idx] == '#'
            numtrees += 1
        end
    end
    return numtrees
end

function part_1(input)
    return count_trees_on_slope(input, right=3, down=1)
end
@info part_1(input)

function part_2(input)
    slopes = ((1,1), (3,1), (5,1), (7,1), (1,2))
    return prod(count_trees_on_slope(input, right=r, down=d) for (r,d) in slopes)
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
    @test part_2(a) == 336
    @test count_trees_on_slope(a, right=1, down=1) == 2
    @test count_trees_on_slope(a, right=5, down=1) == 3
    @test count_trees_on_slope(a, right=7, down=1) == 4
    @test count_trees_on_slope(a, right=1, down=2) == 2
end
