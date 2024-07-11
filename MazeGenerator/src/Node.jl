module NodeModule

export Node

mutable struct Node
    x::Int
    y::Int
    visited::Bool
    wall_right::Bool
    wall_down::Bool
    wall_left::Bool
    wall_up::Bool

    function Node(x::Int, y::Int)
        new(x, y, false, true, true, true, true)
    end
end

end 
