# https://adventofcode.com/2020/day/23
using Revise
using AdventOfCode
using Test, BenchmarkTools

input = parse.(Int, collect(readlines("2020/data/day_23.txt")[1]))

mutable struct Cup
    label::Int
    next::Union{Cup, Nothing}
end
Cup(x::Int) = Cup(x, nothing)

mutable struct Circle
    curr::Cup
end
function Circle(cups::Vector{Cup})
    cups = deepcopy(cups)
    ncups = length(cups)
    circle = Circle(first(cups))
    for i in eachindex(cups)
        cups[i].next = cups[mod1(i+1, ncups)]
    end
    return circle
end
function labels(c::Circle)
    labels = [c.curr.label]
    cup = c.curr.next
    while cup != c.curr
        push!(labels, cup.label)
        cup = cup.next
    end
    return labels
end
function move!(c::Circle)
    curr = c.curr
    
    # remove three next cups from circle
    c1 = curr.next
    c2 = c1.next
    c3 = c2.next
    curr.next = c3.next

    # find extrema
    lo = curr.label
    hi = curr.label
    cup = curr.next
    while cup != curr
        lo = min(lo, cup.label)
        hi = max(hi, cup.label)
        cup = cup.next
    end

    # select destination
    dest = curr
    label = curr.label - 1
    while (dest.label != label)
        dest = dest.next
        any(label .== (c1.label,c2.label,c3.label)) && (label -= 1)
        (label < lo) && (label = hi)
    end

    # insert after destination
    c3.next = dest.next
    dest.next = c1

    # advance current cup
    c.curr = c.curr.next
end

function part_1(input; moves=100)
    cups = Cup.(input)
    circle = Circle(cups)
    for i in 1:moves
        move!(circle)
    end
    l = labels(circle)
    return join(circshift(l, 1-findfirst(==(1), l))[2:end])
end

function part_2(input)
    nothing
end
@info part_2(input)

@testset "day_23" begin
    a = parse.(Int, collect("389125467"))
    @test part_1(input; moves=10) == "92658374"
    @test part_1(input; moves=100) == "67384529"
end

# @time part_1(input; moves=1000000);
# @time part_1(vcat(input, 10:1000); moves=1000000);

part_1(input)