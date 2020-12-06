# https://adventofcode.com/2020/day/6
using AdventOfCode
using Test, BenchmarkTools

input = readlines("2020/data/day_6.txt")

function part_1(input)
    set = Set{Char}()
    n = 0
    for line in input
        if isempty(line)
            n += length(set)
            empty!(set)
        else
            for c in line
                push!(set, c)
            end
        end
    end
    n += length(set)
    return n
end
@info part_1(input)

function part_2(input)
    sets = Vector{Set{Char}}()
    n = 0
    for line in input
        if isempty(line)
            n += length(intersect(sets...))
            empty!(sets)
        else
            push!(sets, Set(line))
        end
    end
    n += length(intersect(sets...))
    return n
end
@info part_2(input)

@testset "day_6" begin
    a = """abc

    a
    b
    c
    
    ab
    ac
    
    a
    a
    a
    a
    
    b"""
    a = split(a, "\n")
    @test part_1(a) == 11
    @test part_2(a) == 6
end
