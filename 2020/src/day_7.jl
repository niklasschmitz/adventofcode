# https://adventofcode.com/2020/day/7
using AdventOfCode
using Test, BenchmarkTools

input = readlines("2020/data/day_7.txt")

function to_adjacencydicts(input)
    adj = Dict()
    for line in input
        outerbag = match(r"(.*) bags contain", line).captures[1]
        for innerbag in eachmatch(r"([0-9]+) ([^,]*) bag", line)
            color = innerbag.captures[2]
            n = parse(Int, innerbag.captures[1])
            if color in keys(adj)
                adj[color][outerbag] = n
            else
                adj[color] = Dict(outerbag => n)
            end
        end
    end
    return adj
end

function part_1(input)
    adj = to_adjacencydicts(input)
    start = "shiny gold"
    visited = Set()
    c = 0
    queue = [start]
    while !isempty(queue)
        v = popfirst!(queue)
        !(v in keys(adj)) && continue
        for (w,_) in adj[v]
            if !(w in visited)
                push!(queue, w)
                push!(visited, w)
                c += 1
            end
        end
    end
    return c
end
@info part_1(input)

function part_2(input)
    nothing
end
@info part_2(input)

@testset "day_7" begin
    a = split("""light red bags contain 1 bright white bag, 2 muted yellow bags.
    dark orange bags contain 3 bright white bags, 4 muted yellow bags.
    bright white bags contain 1 shiny gold bag.
    muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
    shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
    dark olive bags contain 3 faded blue bags, 4 dotted black bags.
    vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
    faded blue bags contain no other bags.
    dotted black bags contain no other bags.""", "\n")
    @test part_1(a) == 4
end

a = split("""light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.""", "\n")

# adjacency lists
fits_in = Dict(
    # weight: "muted yellow" fits into "light red" two times.
    "muted yellow" => [("light red", 2), ("dark orange", 4)],
    "bright white" => [("light red", 1), ("dark orange", 3)]
)

first(match(r"(.*) bags contain", a[1]).captures)
collect(eachmatch(r"([0-9]+) ([^,]*) bag", a[1]))
collect(eachmatch(r"([0-9]+) ([^,]*) bag", a[8]))

to_adjacencylists(a)
