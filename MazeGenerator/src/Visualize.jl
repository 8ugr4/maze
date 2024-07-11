module MazeVisualization

using ..MazeGeneration
using ..NodeModule

export MazeViz

struct MazeViz
    maze::MazeGeneration.Maze
end

function draw_maze(viz::MazeViz)
    maze = viz.maze
    height, width = size(maze.nodes)

    grid = fill('▒', 2 * height + 1, 2 * width + 1)

    # Fuer Wege und Waende
    for i in 1:height
        for j in 1:width
            grid[2 * i, 2 * j] = ' '  # Path for each node
            if !maze.nodes[i, j].wall_right && j < width
                grid[2 * i, 2 * j + 1] = ' '  # Path to the right
            end
            if !maze.nodes[i, j].wall_down && i < height
                grid[2 * i + 1, 2 * j] = ' '  # Path downward
            end
        end
    end

    # Loesungsweg visualisierung
    if !isnothing(maze.path)
        for node in maze.path
            grid[2 * node.x, 2 * node.y] = '·'
        end
    end

    # Anfang und Ende
    grid[2, 2] = '☻'
    grid[2 * height, 2 * width] = '★'

    #zu string fuer display
    output = join([join(row, "") for row in eachrow(grid)], "\n")
    return output
end

import Base.show

function show(io::IO, viz::MazeViz)
    println(io, draw_maze(viz))
end

end
