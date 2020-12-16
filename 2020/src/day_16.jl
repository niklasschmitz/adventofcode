# https://adventofcode.com/2020/day/16
using AdventOfCode
using Test, BenchmarkTools

input = readlines("2020/data/day_16.txt")

function to_range(str)
    lo, hi = split(str, "-")
    return parse(Int, lo):parse(Int, hi)
end

function part_1(input; preamble=20)
    ranges = map.(to_range, (split.(getindex.(split.(input[1:preamble], ": "), 2), " or ")))
    invalid_vals = Int[]
    for line in input[preamble+6:end]
        vals = parse.(Int, split(line, ","))
        nvalids = 0
        for val in vals
            isvalid = false
            for r in ranges
                ((val in r[1]) || (val in r[2])) && (isvalid = true) && break
            end
            (!isvalid) && push!(invalid_vals, val)
            nvalids += isvalid
        end
    end
    return sum(invalid_vals)
end
@info part_1(input)

function part_2(input; preamble=20, steps=1000)
    println("part_2")
    ranges = map.(to_range, (split.(getindex.(split.(input[1:preamble], ": "), 2), " or ")))
    
    println("collect only valid lines")
    valid_lines = []
    for line in input[preamble+6:end]
        vals = parse.(Int, split(line, ","))
        nvalids = 0
        for val in vals
            isvalid = false
            for r in ranges
                ((val in r[1]) || (val in r[2])) && (isvalid = true) && break
            end
            nvalids += isvalid
        end
        (nvalids ≥ length(vals)) && push!(valid_lines, vals)
    end

    println("find the permutation matrix that matches value fields to range fields")
    canbe = trues(preamble, preamble) # canbe[i,j] iff valfield i can be rangefield j
    n = sum(canbe)
    for vals in Iterators.cycle(valid_lines)
        (n ≤ preamble) && break
        for i in 1:preamble
            for j in 1:preamble
                if canbe[i,j] && !(vals[i] in ranges[j][1]) && !(vals[i] in ranges[j][2])
                    canbe[i,j] = false 
                    n -= 1
                end
            end

            # enforce mutual exclusion, once known
            canbe_i = findall(view(canbe, i, :))
            if length(canbe_i) == 1
                j_ = canbe_i[1]
                for i_ in 1:preamble
                    if i_ != i
                        canbe[i_, j_] && (n -= 1)
                        canbe[i_, j_] = false
                    end
                end
            end
        end

        (steps < 1) && break
        steps -= 1
    end
    println(steps, " ", n)

    println("compute answer based on own ticket")
    myvals = parse.(Int, split(input[preamble+3], ","))
    permuted = canbe' * myvals
    return prod(permuted[1:6])
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
    @test part_1(a; preamble=3) == 71
end

input[1:20]

b = split("""class: 0-1 or 4-19
row: 0-5 or 8-19
seat: 0-13 or 16-19

your ticket:
11,12,13

nearby tickets:
3,9,18
15,1,5
5,14,9""", "\n")
part_2(b; preamble=3)
