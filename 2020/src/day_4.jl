# https://adventofcode.com/2020/day/4
using AdventOfCode
using Test, BenchmarkTools

input = readlines("2020/data/day_4.txt")

function part_1(input)
    fieldindex = Dict("byr"=>1, "iyr"=>2, "eyr"=>3, 
        "hgt"=>4, "hcl"=>5, "ecl"=>6, "pid"=>7)
    passport = falses(7)
    nvalid = 0
    for line in input
        if isempty(line)
            all(passport) && (nvalid += 1)
            passport .= false
        else
            pairs = split(line)
            fields = map(pair -> split(pair, ":")[1], pairs)
            for field in fields
                (field == "cid") && continue
                passport[fieldindex[field]] = true
            end
        end
    end
    all(passport) && (nvalid += 1)
    return nvalid
end
@info part_1(input)

function part_2(input)
    nothing
end
@info part_2(input)

@testset "day_4" begin
    a = """ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
    byr:1937 iyr:2017 cid:147 hgt:183cm

    iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
    hcl:#cfa07d byr:1929

    hcl:#ae17e1 iyr:2013
    eyr:2024
    ecl:brn pid:760753108 byr:1931
    hgt:179cm

    hcl:#cfa07d eyr:2025 pid:166559648
    iyr:2011 ecl:brn hgt:59in"""
    a = split(a, "\n")
    @test part_1(a) == 2
end

count(isempty, input)
part_1(input)

