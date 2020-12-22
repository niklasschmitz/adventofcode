# https://adventofcode.com/2020/day/22
using AdventOfCode
using Test, BenchmarkTools

input = readlines("2020/data/day_22.txt")

function preprocess(input)
    mid = findfirst(isempty, input)
    player1 = parse.(Int, input[2:mid-1])
    player2 = parse.(Int, input[mid+2:end])
    return player1, player2
end

p1, p2 = preprocess(input)

function step!(p1, p2)
    c1 = popfirst!(p1)
    c2 = popfirst!(p2)
    c1 > c2 ? push!(p1, c1, c2) : push!(p2, c2, c1)
end

function part_1(input)
    p1, p2 = preprocess(input)
    winner = p1
    n = 0
    while true
        @show n+=1
        step!(p1, p2)
        if isempty(p1)
            winner = p2
            break
        elseif isempty(p2)
            winner = p1
            break
        end
    end
    return sum(collect(1:length(winner)) .* reverse(winner))
end
@info part_1(input)

function part_2(input)
    nothing
end
@info part_2(input)

@testset "day_22" begin
    a = split("""Player 1:
    9
    2
    6
    3
    1

    Player 2:
    5
    8
    4
    7
    10""", "\n")
    @test part_1(a) == 306
end
