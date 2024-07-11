include("Node.jl")
include("MazeGeneration.jl")
include("Solver.jl")
include("Visualize.jl")

using .MazeGeneration
using .NodeModule
using .Solver
using .MazeVisualization

function main()
    maze = MazeGeneration.Maze(5, 5)
    MazeGeneration.generate_maze!(maze)

    path = Solver.solve_maze(maze)
    maze.path = path  # Path ist im maze struct

    # maze visualisierung
    viz = MazeVisualization.MazeViz(maze)  # makes sure its correct module path
    println(viz)  # Base.show method

    if !isnothing(path)
        println("Path found: ", path)
    else
        println("No path found")
    end
end

main()
