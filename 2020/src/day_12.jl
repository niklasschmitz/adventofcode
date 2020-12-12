# https://adventofcode.com/2020/day/12
using AdventOfCode
using Test, BenchmarkTools

input = readlines("2020/data/day_12.txt")

function part_1(input)
    pos = 0 + 0im
    right = 1 + 0im
    up = 0 + 1im
    dir = 1 + 0im
    rot90 = 1im
    for line in input
        cmd, n = line[1], parse.(Int, line[2:end])
        if (cmd == 'N') pos += n * up
        elseif (cmd == 'S') pos -= n * up
        elseif (cmd == 'E') pos += n * right
        elseif (cmd == 'W') pos -= n * right
        elseif (cmd == 'L') dir *= rot90^(n ÷ 90)
        elseif (cmd == 'R') dir *= (-rot90)^(n ÷ 90)
        elseif (cmd == 'F') pos += n * dir
        end
    end
    return abs(real(pos)) + abs(imag(pos))
end
@info part_1(input)

function part_2(input)
    pos = 0 + 0im
    right = 1 + 0im
    up = 0 + 1im
    waypoint = 10 + 1im
    rot90 = 1im
    for line in input
        cmd, n = line[1], parse.(Int, line[2:end])
        if (cmd == 'N') waypoint += n * up
        elseif (cmd == 'S') waypoint -= n * up
        elseif (cmd == 'E') waypoint += n * right
        elseif (cmd == 'W') waypoint -= n * right
        elseif (cmd == 'L') waypoint *= rot90^(n ÷ 90)
        elseif (cmd == 'R') waypoint *= (-rot90)^(n ÷ 90)
        elseif (cmd == 'F') pos += n * waypoint
        end
    end
    return abs(real(pos)) + abs(imag(pos))
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
