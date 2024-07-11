module MazeGeneration

using ..NodeModule

export Maze, generate_maze!, neighbors, Node

mutable struct Maze
    nodes::Matrix{Node}
    visual::Union{Nothing, Any}
    path::Union{Nothing, Vector{Node}}
end

function neighbors(node::Node, maze::Matrix{Node})
    neighbors_list = Node[]
    x, y = node.x, node.y
    directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

    for (dx, dy) in directions
        nx, ny = x + dx, y + dy
        if 1 <= nx <= size(maze, 1) && 1 <= ny <= size(maze, 2) && !maze[nx, ny].visited
            push!(neighbors_list, maze[nx, ny])
        end
    end

    return neighbors_list
end

function Maze(height::Int, width::Int)
    nodes = [Node(i, j) for i in 1:height, j in 1:width]
    return Maze(nodes, nothing, nothing)
end

function remove_wall_between(current::Node, next::Node)
    if current.x == next.x
        if current.y < next.y
            current.wall_right = false
            next.wall_left = false
        else
            current.wall_left = false
            next.wall_right = false
        end
    elseif current.y == next.y
        if current.x < next.x
            current.wall_down = false
            next.wall_up = false
        else
            current.wall_up = false
            next.wall_down = false
        end
    end
end

function generate_maze!(maze::Maze)
    stack = []
    start_node = maze.nodes[rand(1:size(maze.nodes, 1)), rand(1:size(maze.nodes, 2))]
    start_node.visited = true
    push!(stack, start_node)

    println("Starting maze generation")

    while !isempty(stack)
        current = stack[end]
        println("Current node: ", current)
        unvisited_neighbors = neighbors(current, maze.nodes)

        if !isempty(unvisited_neighbors)
            next_node = rand(unvisited_neighbors)
            next_node.visited = true
            remove_wall_between(current, next_node)
            push!(stack, next_node)
            println("Visited node: ", next_node)
        else
            println("Backtracking from: ", current)
            pop!(stack)
        end
    end

    println("Maze generation complete")
    return maze
end

end 
