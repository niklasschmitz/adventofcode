# https://adventofcode.com/2020/day/8
using AdventOfCode
using Test, BenchmarkTools

input = readlines("2020/data/day_8.txt")

function simulate(program)
    visited = falses(length(program))
    acc = 0
    idx = 1
    terminated = false
    while true
        (idx > length(program)) && (terminated = true) && break 
        visited[idx] && break
        visited[idx] = true
        if program[idx][1] == "jmp"
            idx += program[idx][2]
            continue
        elseif program[idx][1] == "acc"
            acc += program[idx][2]
        end
        idx += 1
    end
    return acc, terminated
end

function part_1(input)
    program = map(s -> (s[1:3], parse(Int, s[5:end])), input)
    acc, _ = simulate(program)
    return acc
end
@info part_1(input)

function part_2(input)
    program = map(s -> (s[1:3], parse(Int, s[5:end])), input)
    for (idx, (op, val)) in enumerate(program)
        if op == "jmp"
            program[idx] = ("nop", val)
            acc, terminated = simulate(program)
            terminated && return acc
            program[idx] = ("jmp", val)
        elseif op == "nop"
            program[idx] = ("jmp", val)
            acc, terminated = simulate(program)
            terminated && return acc
            program[idx] = ("nop", val)
        end
    end
    return -1
end
@info part_2(input)

@testset "day_8" begin
    a = split("""nop +0
    acc +1
    jmp +4
    acc +3
    jmp -3
    acc -99
    acc +1
    jmp -4
    acc +6""", "\n")
    @test part_1(a) == 5
    @test part_2(a) == 8
end
