# https://adventofcode.com/2020/day/13
using AdventOfCode
using Test, BenchmarkTools

input = readlines("2020/data/day_13.txt")

# observe: all bus IDs are primes

function part_1(input)
    start = parse(Int, input[1])
    ids = parse.(Int, filter(!=("x"), split(input[2], ",")))
    eachearliest = map(ids) do id
        Int(ceil(start / id) * id - start)
    end
    minval, idx = findmin(eachearliest)
    return minval * ids[idx]
end
@info part_1(input)

function solvecrt(moduli, remainders)
    # solve a system of modular equations,
    # using the chinese remainder theorem.
    # x % moduli[i] = remainders[i] for all i
    # https://en.wikipedia.org/wiki/Chinese_remainder_theorem#Existence_(constructive_proof)
    # NOTE: moduli have to be pairwise coprime
    @assert length(moduli) == length(remainders)
    prod_moduli = prod(moduli)
    N = prod_moduli .÷ moduli
    M = [invmod(N[i], moduli[i]) for i in eachindex(moduli)]
    x = sum(remainders .* M .* N) % prod_moduli
    return x
end

function part_2(input)
    ids = tryparse.(Int, split(input[2], ","))
    ids = map(x -> isnothing(x) ? -1 : x, ids)
    idx = findall(ids .!= -1)
    nums = ids[idx]
    rems = nums .- idx .+ 1
    rems[1] = 0
    return solvecrt(nums, rems)
end
@info part_2(input)

@testset "day_13" begin
    a = split("""939
    7,13,x,x,59,x,31,19""", "\n")
    @test part_1(a) == 295
    @test part_2(a) == 1068781
    b = split("""939
    17,x,13,19""", "\n")
    c = split("""939
    67,7,59,61""", "\n")
    d = split("""939
    67,x,7,59,61""", "\n")
    e = split("""939
    67,7,x,59,61""", "\n")
    f = split("""939
    1789,37,47,1889""", "\n")
    @test part_2(b) == 3417
    @test part_2(c) == 754018
    @test part_2(d) == 779210
    @test part_2(e) == 1261476
    @test part_2(f) == 1202161486
end
