# https://adventofcode.com/2020/day/14
using AdventOfCode
using Test, BenchmarkTools

input = readlines("2020/data/day_14.txt")

function part_1(input)
    mask0 = 0
    mask1 = 0
    mem = Dict{Int,Int}()
    for line in input
        if line[1:4] == "mask"
            mask0 = parse(Int, replace(line[end-35:end], "X"=>1), base=2)
            mask1 = parse(Int, replace(line[end-35:end], "X"=>0), base=2)
        else
            addr, val = split(line, "] = ")
            addr = parse(Int, addr[5:end])
            val = parse(Int, val)
            val |= mask1
            val &= mask0
            mem[addr] = val
        end
    end
    return sum(values(mem))
end
@info part_1(input)

# gets the i-th (starting with 0 for LSB) bit of an integer n
@inline getbit(n, i) = (n >> i) % 2

function part_2(input)
    mask0 = 0
    mask1 = 0
    maskx = Int[]
    mem = Dict{Int,Int}()
    for line in input
        if line[1:4] == "mask"
            m = line[end-35:end]
            mask0 = parse(Int, replace(m, "X"=>1), base=2)
            mask1 = parse(Int, replace(m, "X"=>0), base=2)
            maskx = length(m) .- findall(==('X'), m)
        else
            addr, val = split(line, "] = ")
            addr = parse(Int, addr[5:end])
            addr |= mask1
            val = parse(Int, val)
            if !isempty(maskx)
                n = length(maskx)
                for idx in maskx
                    addr -= getbit(addr, idx) << idx # zero out all X bits
                end
                for x in 0:(2^n - 1)
                    addr2 = addr
                    for (i, idx) in enumerate(maskx)
                        addr2 += getbit(x, i-1) << idx
                    end
                    mem[addr2] = val
                end
            else
                mem[addr] = val
            end
        end
    end
    return sum(values(mem))
end
@info part_2(input)

@testset "day_14" begin
    a = split("""mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
    mem[8] = 11
    mem[7] = 101
    mem[8] = 0""", "\n")
    @test part_1(a) == 165
    b = split("""mask = 000000000000000000000000000000X1001X
    mem[42] = 100
    mask = 00000000000000000000000000000000X0XX
    mem[26] = 1""", "\n")
    @test part_2(b) == 208
end
