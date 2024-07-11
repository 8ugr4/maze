module TestNodes

using ..NodeModule
using ..MazeGeneration
using ..Solver
using Test

export run_tests

function run_tests()
    @testset "Node tests" begin
        node = Node(1, 1, false)
        @test node.x == 1
        @test node.y == 1
        @test !node.visited

        maze = Maze(5, 5)
        @test size(maze.nodes) == (5, 5)
    end

    @testset "Maze generation tests" begin
        maze = Maze(5, 5)
        generate_maze!(maze)
        visited_nodes = sum([n.visited for row in eachrow(maze.nodes) for n in row])
        @test visited_nodes == 25
    end

    @testset "Maze solving tests" begin
        maze = Maze(5, 5)
        generate_maze!(maze)
        path = Solver.solve_maze(maze)
        @test path != nothing
        @test path[1] == maze.nodes[1, 1]
        @test path[end] == maze.nodes[end, end]
    end
end

end
