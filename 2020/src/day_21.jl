# https://adventofcode.com/2020/day/21
using AdventOfCode
using Test, BenchmarkTools

input = readlines("2020/data/day_21.txt")

function part_1(input)
    allergens2ingredients = Dict{String, Set{String}}()
    all_ingredients = Set{String}()
    all_occurences = String[]
    for line in input
        ingredients, allergens = split(line, " (contains ")
        append!(all_occurences, split(ingredients))
        ingredients = Set(split(ingredients))
        union!(all_ingredients, ingredients)
        allergens = split(allergens[1:end-1], ", ")
        for a in allergens
            if a ∉ keys(allergens2ingredients)
                allergens2ingredients[a] = ingredients
            else
                intersect!(allergens2ingredients[a], ingredients)
            end
        end
    end
    resolved_ingredients = union(values(allergens2ingredients)...)
    unresolved = setdiff(all_ingredients, resolved_ingredients)
    return sum(u == x for x in all_occurences for u in unresolved)
end
@info part_1(input)

function part_2(input)
    nothing
end
@info part_2(input)

@testset "day_21" begin
    a = split("""mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
    trh fvjkl sbzzf mxmxvkd (contains dairy)
    sqjhc fvjkl (contains soy)
    sqjhc mxmxvkd sbzzf (contains fish)""", "\n")
    @test part_1(a) == 5
end
