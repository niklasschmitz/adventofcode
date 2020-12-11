# https://adventofcode.com/2020/day/11
using AdventOfCode
using Test, BenchmarkTools

input = hcat(collect.(readlines("2020/data/day_11.txt"))...)

function pad(state, with='.')
    padded = fill(with, size(state) .+ 2)
    padded[2:end-1,2:end-1] = state
    return padded
end

function fixed_point(f, state; maxsteps=1000)
    next = f(state)
    for i in 1:maxsteps
        (state == next) && return (state, true)
        state = next
        next = f(state)
    end
    return (state, false)  # no fixed point reached
end

function simulate1(state)
    next = deepcopy(state)
    for I in CartesianIndices(state)
        (state[I] == '.') && continue
        neigh = I .+ (CartesianIndex(-1,-1):CartesianIndex(1,1))
        c = count(==('#'), @view state[neigh])
        if state[I] == 'L'
            (c == 0) && (next[I] = '#')
        else
            (c > 4) && (next[I] = 'L')
        end
    end
    return next
end

function part_1(input)
    state = pad(input)
    fp, converged = fixed_point(simulate1, state)
    return converged ? count(==('#'), fp) : -1
end
@info part_1(input)

function simulate2(state)
    next = deepcopy(state)
    for I in CartesianIndices(state)
        (state[I] == 'x') && continue
        (state[I] == '.') && continue
        c = 0
        for direction in (CartesianIndex(-1,-1):CartesianIndex(1,1))
            s = 1
            while state[I + s*direction] == '.'
                s += 1
            end
            (state[I + s*direction] == '#') && (c += 1)
        end
        if state[I] == 'L'
            (c == 0) && (next[I] = '#')
        else
            (c > 5) && (next[I] = 'L')
        end
    end
    return next
end

function part_2(input)
    state = pad(input, 'x')
    fp, converged = fixed_point(simulate2, state)
    return converged ? count(==('#'), fp) : -1
end
@info part_2(input)

@testset "day_11" begin
    a = permutedims(hcat(collect.(split("""#.##.##.##
    #######.##
    #.#.#..#..
    ####.##.##
    #.##.##.##
    #.#####.##
    ..#.#.....
    ##########
    #.######.#
    #.#####.##""", "\n"))...))
    @test part_1(a) == 37
    @test part_2(a) == 26
end
