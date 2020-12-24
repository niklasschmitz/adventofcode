# https://adventofcode.com/2020/day/24
using AdventOfCode
using Test, BenchmarkTools

input = split(
    """sesenwnenenewseeswwswswwnenewsewsw
    neeenesenwnwwswnenewnwwsewnenwseswesw
    seswneswswsenwwnwse
    nwnwneseeswswnenewneswwnewseswneseene
    swweswneswnenwsewnwneneseenw
    eesenwseswswnenwswnwnwsewwnwsene
    sewnenenenesenwsewnenwwwse
    wenwwweseeeweswwwnwwe
    wsweesenenewnwwnwsenewsenwwsesesenwne
    neeswseenwwswnwswswnw
    nenwswwsewswnenenewsenwsenwnesesenew
    enewnwewneswsewnwswenweswnenwsenwsw
    sweneswneswneneenwnewenewwneswswnese
    swwesenesewenwneswnwwneseswwne
    enesenwswwswneneswsenwnewswseenwsese
    wnwnesenesenenwwnenwsewesewsesesew
    nenewswnwewswnenesenwnesewesw
    eneswnwswnwsenenwnwnwwseeswneewsenese
    neswnwewnwnwseenwseesewsenwsweewe
    wseweeenwnesenwwwswnew""", "\n"
)


parse_direction(str) = replace(
    collect(replace(replace(replace(replace(replace(replace(str, 
        "sw" => 1),
        "se" => 2),
        "nw" => 3),
        "ne" => 4),
        "e" => 5),
        "w" => 6)
    ),
    '1'=>[0,-1], '2'=>[1,-1], '3'=>[-1,1], '4'=>[0,1], '5'=>[1,0], '6'=>[-1,0])

function part_1(input)
    x = sum.(parse_direction.(input))
    return mapreduce(tile -> count(==(tile), x) % 2, +, unique(x))
end

function part_2(input; days=100)
    dirs = [[0,-1], [1,-1], [-1,1], [0,1], [1,0], [-1,0]]
    x = sum.(parse_direction.(input))
    black = Set(filter(tile -> count(==(tile), x) % 2 == 1, unique(x)))
    for d in 1:days
        nextblack = Set{Vector{Int}}()
        candidates = Set{Vector{Int}}()
        for tile in black
            neighbors = Ref(tile) .+ dirs
            push!(candidates, neighbors...)
        end
        for tile in candidates
            neighbors = Ref(tile) .+ dirs
            push!(candidates, neighbors...)
            blackneighbors = sum(x in black for x in neighbors)
            if (tile in black) && !((blackneighbors == 0) || (blackneighbors > 2))
                push!(nextblack, tile)
            elseif !(tile in black) && (blackneighbors == 2)
                push!(nextblack, tile)
            end
        end
        black = nextblack
        # println("Day $d: ", length(black))
    end
    return length(black)
end

@testset "day_24" begin
    a = split(
        """sesenwnenenewseeswwswswwnenewsewsw
        neeenesenwnwwswnenewnwwsewnenwseswesw
        seswneswswsenwwnwse
        nwnwneseeswswnenewneswwnewseswneseene
        swweswneswnenwsewnwneneseenw
        eesenwseswswnenwswnwnwsewwnwsene
        sewnenenenesenwsewnenwwwse
        wenwwweseeeweswwwnwwe
        wsweesenenewnwwnwsenewsenwwsesesenwne
        neeswseenwwswnwswswnw
        nenwswwsewswnenenewsenwsenwnesesenew
        enewnwewneswsewnwswenweswnenwsenwsw
        sweneswneswneneenwnewenewwneswswnese
        swwesenesewenwneswnwwneseswwne
        enesenwswwswneneswsenwnewswseenwsese
        wnwnesenesenenwwnenwsewesewsesesew
        nenewswnwewswnenesenwnesewesw
        eneswnwswnwsenenwnwnwwseeswneewsenese
        neswnwewnwnwseenwseesewsenwsweewe
        wseweeenwnesenwwwswnew""", "\n"
    )
    @test part_1(a) == 10
end

input = readlines("2020/data/day_24.txt")
part_1(input)
part_2(input)
