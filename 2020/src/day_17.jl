# https://adventofcode.com/2020/day/17
using AdventOfCode
using Test, BenchmarkTools

preprocess(x) = BitArray((==('#')).(hcat(collect.(x)...))')
input = preprocess(readlines("2020/data/day_17.txt"))

function simulate(input, cycles, ndim)
    m, n = size(input)
    state = falses(m + 2cycles + 2, n + 2cycles + 2, fill(1 + 2cycles + 2, ndim-2)...)
    state[cycles+2:cycles+n+1, cycles+2:cycles+n+1, fill(cycles+2, ndim-2)...] .= input
    window = CartesianIndex(fill(-1, ndim)...):CartesianIndex(fill(1, ndim)...)
    next = copy(state)
    for _ in 1:cycles
        for xyz in CartesianIndices(state)
            (any(xyz.I .≤ 1) || any(xyz.I .≥ size(state))) && continue
            s = sum(view(state, xyz .+ window))
            s -= state[xyz]
            state[xyz] && !(s in (2,3)) && (next[xyz] = false)
            !state[xyz] && (s == 3) && (next[xyz] = true)
        end
        state .= next
    end
    return sum(state)
end

part_1(input) = simulate(input, 6, 3)
part_2(input) = simulate(input, 6, 4)

part_1(input)
part_2(input)

@testset "day_17" begin
    a = preprocess(split(""".#.
    ..#
    ###""", "\n"))
    @test part_1(a) == 112
    @test part_2(a) == 848
end
