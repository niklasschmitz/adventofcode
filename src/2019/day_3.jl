# https://adventofcode.com/2019/day/3
# following https://github.com/Arkoniak/advent_of_code/blob/master/2019/03/day03.jl
using AdventOfCode

const input = readlines("data/2019/day_3.txt")

struct Point
    x::Int
    y::Int
end

dist(p::Point) = abs(p.x) + abs(p.y)

function Base.:+(p::Point, dir::Char)
    if dir == 'U'
        return Point(p.x, p.y+1)
    elseif dir == 'R'
        return Point(p.x+1, p.y)
    elseif dir == 'D'
        return Point(p.x, p.y-1)
    else
        return Point(p.x-1, p.y)
    end
end

Base.:+(p::Point, dir::String) = Base.:+(p, dir[1])

function extractpath(s)
    p = Point(0,0)
    path = Vector{Point}()
    for move in split(s, ",")
        dir = move[1]
        steps = parse(Int, move[2:end])
        for i in 1:steps
            p += dir
            push!(path, p)
        end
    end
    return path
end

function part_1(input)
    path1 = extractpath(input[1])
    path2 = extractpath(input[2])
    return minimum(dist.(intersect(path1, path2)))
end
@info part_1(input)

function part_2(input)
    nothing
end
@info part_2(input)
