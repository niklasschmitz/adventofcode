# https://adventofcode.com/2020/day/12
using AdventOfCode
using Test, BenchmarkTools

input = readlines("2020/data/day_12.txt")

function part_1(input)
    pos = [0, 0]
    right = [1, 0]
    up = [0, 1]
    dir = 0
    for line in input
        cmd, n = line[1], parse.(Int, line[2:end])
        if (cmd == 'N') pos += n * up
        elseif (cmd == 'S') pos -= n * up
        elseif (cmd == 'E') pos += n * right
        elseif (cmd == 'W') pos -= n * right
        elseif (cmd == 'L') dir += n % 360
        elseif (cmd == 'R') dir += (360 - n) % 360
        elseif (cmd == 'F') 
            if (dir == 0) pos += n * right
            elseif (dir == 90) pos += n * up
            elseif (dir == 180) pos -= n * right
            elseif (dir == 270) pos -= n * up
            else throw(ErrorException("dir=$dir"))
            end
        end
        dir %= 360
    end
    return sum(abs.(pos))
end
@info part_1(input)

function part_2(input)
    pos = [0, 0]
    right = [1, 0]
    up = [0, 1]
    waypoint = [10, 1]
    rot90 = [0 -1; 1 0]
    rotations = Dict(
        90 => rot90,
        180 => rot90^2,
        270 => rot90^3,
        0 => rot90^4
    )
    for line in input
        cmd, n = line[1], parse.(Int, line[2:end])
        if (cmd == 'N') waypoint += n * up
        elseif (cmd == 'S') waypoint -= n * up
        elseif (cmd == 'E') waypoint += n * right
        elseif (cmd == 'W') waypoint -= n * right
        elseif (cmd == 'L') waypoint = rotations[n % 360] * waypoint
        elseif (cmd == 'R') waypoint = rotations[(360 - n) % 360] * waypoint
        elseif (cmd == 'F') pos += n * waypoint
        end
    end
    return sum(abs.(pos))
end
@info part_2(input)

@testset "day_12" begin
    a = split(
        """F10
        N3
        F7
        R90
        F11""","\n"
    )
    @test part_1(a) == 25
    @test part_2(a) == 286
end
