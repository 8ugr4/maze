module Solver

using ..NodeModule
using ..MazeGeneration

export solve_maze

function solve_maze(maze::Maze)
    start_node = maze.nodes[1, 1]
    goal_node = maze.nodes[end, end]
    path = [start_node]
    visited = Set([start_node])

    println("Starting maze solver")
    println("Start node: ", start_node)
    println("Goal node: ", goal_node)

    if _solve_maze_right_hand!(maze, start_node, goal_node, path, visited, 1)
        println("Path found: ", path)
        maze.path = path
        return path
    else
        println("No path found")
        return nothing
    end
end

function _solve_maze_right_hand!(maze::Maze, current::Node, goal::Node, path::Vector{Node}, visited::Set{Node}, current_direction::Int)
    println("Visiting node: ", current)

    if current == goal
        return true
    end

    # Define the directions in the order of right, down, left, and up
    directions = [(0, 1), (1, 0), (0, -1), (-1, 0)] # right, down, left, up
    walls = [:wall_right, :wall_down, :wall_left, :wall_up] # corresponding walls

    for i in 0:3
        next_direction = mod(current_direction + i, 4)
        (dx, dy) = directions[next_direction + 1]
        next_x = current.x + dx
        next_y = current.y + dy

        if 1 <= next_x <= size(maze.nodes, 1) && 1 <= next_y <= size(maze.nodes, 2)
            neighbor = maze.nodes[next_x, next_y]

            if !(neighbor in visited)
                # Check the corresponding wall based on the direction
                if !getfield(current, walls[next_direction + 1])
                    println("Moving from ", current, " to ", neighbor, " in direction ", next_direction)
                    push!(path, neighbor)
                    push!(visited, neighbor)
                    if _solve_maze_right_hand!(maze, neighbor, goal, path, visited, next_direction)
                        return true
                    end
                    println("Backtracking from: ", neighbor)
                    pop!(path)
                else
                    println("Wall in direction ", next_direction, " from node ", current)
                end
            end
        end
    end

    return false
end

end
