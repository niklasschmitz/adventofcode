# https://adventofcode.com/2020/day/21
using AdventOfCode
using Test, BenchmarkTools

input = readlines("2020/data/day_21.txt")

function parse_input(input)
    allergens2ingredients = Dict{String, Set{String}}()
    all_ingredients = String[]
    for line in input
        ingredients, allergens = split(line, " (contains ")
        append!(all_ingredients, split(ingredients))
        ingredients = Set(split(ingredients))
        allergens = split(allergens[1:end-1], ", ")
        for a in allergens
            if a ∉ keys(allergens2ingredients)
                allergens2ingredients[a] = ingredients
            else
                intersect!(allergens2ingredients[a], ingredients)
            end
        end
    end
    return allergens2ingredients, all_ingredients
end

function part_1(input)
    allergens2ingredients, all_ingredients = parse_input(input)
    resolved_ingredients = union(values(allergens2ingredients)...)
    unresolved = setdiff(all_ingredients, resolved_ingredients)
    return sum(u == x for x in all_ingredients for u in unresolved)
end
@info part_1(input)

function part_2(input)
    allergens2ingredients, all_ingredients = parse_input(input)
    allergens = sort(collect(keys(allergens2ingredients)))
    all_ingredients = collect(all_ingredients)
    ingredients = unique(all_ingredients)
    M = falses(length(allergens), length(ingredients))

    for (ia, a) in enumerate(allergens)
        for (ib, b) in enumerate(ingredients)
            M[ia, ib] = b in allergens2ingredients[a]
        end
    end

    n = 10000
    inds = Set(1:length(allergens))
    while (n-=1) > 0
        for i in inds
            if sum(view(M, i, :)) == 1
                for j in 1:length(allergens)
                    (j==i) && continue
                    M[j,:] .&= .!(M[i,:])
                end
                delete!(inds, i)
            end
        end
        all(sum(M, dims=1) .∈ Ref((0,1))) && all(sum(M, dims=2) .== 1) && break
    end
    # @show sum(M, dims=1)
    # @show sum(M, dims=2)
    # @show n
    return join([ingredients[findfirst(view(M, i, :))] for i in 1:size(M, 1)], ",")
end
@info part_2(input)

@testset "day_21" begin
    a = split("""mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
    trh fvjkl sbzzf mxmxvkd (contains dairy)
    sqjhc fvjkl (contains soy)
    sqjhc mxmxvkd sbzzf (contains fish)""", "\n")
    @test part_1(a) == 5
    @test part_2(a) == "mxmxvkd,sqjhc,fvjkl"
end
