# https://adventofcode.com/2020/day/1
using AdventOfCode
using BenchmarkTools, Test

input = parse.(Int, readlines("data/2020/day_1.txt"))

function part_1(a)
    for i in 1:length(a)
        for j in (i+1):length(a)
            if a[j] == 2020 - a[i]
                return a[i]*a[j]
            end
        end
    end
end
@info part_1(input)

function part_2(a)
    for k in 1:length(a)
        for i in (k+1):length(a)
            for j in (i+1):length(a)
                if a[j] == 2020 - a[i] - a[k]
                    return a[i]*a[j]*a[k]
                end
            end
        end
    end
end
@info part_2(input)

# unit tests
@testset "day 1" begin
    a = [1721, 979, 366, 299, 675, 1456]
    @test part_1(a) == 514579
    @test part_2(a) == 241861950
end

# benchmark
@btime part_1($input)
@btime part_2($input)

""" Colin Caine """
function part2(input)
    input = sort(input)
    for a in input
        for b in @view input[2:end]
            c = 2020 - a - b
            idx = searchsortedfirst(input, c)
            input[idx] == c && (@debug a, b, c; return a * b * c)
        end
    end
end
@btime part2($input)
