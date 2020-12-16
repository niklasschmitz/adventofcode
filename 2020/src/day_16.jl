# https://adventofcode.com/2020/day/16
using AdventOfCode
using Test, BenchmarkTools

input = readlines("2020/data/day_16.txt")

function to_range(str)
    lo, hi = split(str, "-")
    return parse(Int, lo):parse(Int, hi)
end

function part_1(input; to=20)
    ranges = map.(to_range, (split.(getindex.(split.(input[1:to], ": "), 2), " or ")))
    invalid_vals = Int[]
    for line in input[to+6:end]
        vals = parse.(Int, split(line, ","))
        valids = 0
        for val in vals
            isvalid = false
            for r in ranges
                ((val in r[1]) || (val in r[2])) && (isvalid = true) && break
            end
            (!isvalid) && push!(invalid_vals, val)
            valids += isvalid
        end
        # if valids < length(vals)
        #     println("invalid")
        # end
    end
    return sum(invalid_vals)
end
@info part_1(input)

function part_2(input)
    nothing
end
@info part_2(input)

@testset "day_16" begin
    a = split("""class: 1-3 or 5-7
    row: 6-11 or 33-44
    seat: 13-40 or 45-50
    
    your ticket:
    7,1,14
    
    nearby tickets:
    7,3,47
    40,4,50
    55,2,20
    38,6,12""", "\n")
    @test part_1(a; to=3) == 71
end

input[1:20]

getindex.(split.(input[1:20], ": "), 2)



ranges = map.(to_range, (split.(getindex.(split.(input[1:20], ": "), 2), " or ")))

parse.(Int, split(input[30], ","))