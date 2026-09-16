import Base: +
+(x::String, y::String) = string(x,y)



println("TP1 - Modélisation de graphes")

node_names = ["A", "B", "C", "D", "E", "F", "G", "H", "I"]

println("\n", "----Matrix----")
m = [ 
0 1 1 0 0 0 0 0 0 ; 
1 0 0 1 1 0 0 0 0 ; 
1 0 0 0 0 1 0 0 0 ;
0 1 0 0 0 0 0 0 0 ;
0 1 0 0 0 0 0 0 0 ;
0 0 1 0 0 0 1 1 1 ;
0 0 0 0 0 1 0 0 0 ;
0 0 0 0 0 1 0 0 0 ;
0 0 0 0 0 1 0 0 0 ;
]


for i in 1:9
    rlt = "The node " + node_names[i] + " is connected to : "
    for j in 1:9
        if m[i,j] == 1
            rlt = rlt + node_names[j] + " "
        end
    end
    println(rlt)
end

println("\n", "----Adjacent list----")
al = [
    [2, 3],
    [1, 4, 5],
    [1, 6],
    [2],
    [2],
    [3, 7, 8, 9],
    [6],
    [6],
    [6]
]

for i in 1:9
    rlt = "The node " + node_names[i] + " is connected to : "
    for j in al[i]
        rlt = rlt + node_names[j] + " "
    end
    println(rlt)
end


read_graph = function(filename::String)
    open(filename, "r") do io
        lines = readlines(io)
        nb_nodes = parse(Int64, lines[1])
        nb_relations = parse(Int64, lines[2])
        al = [ Vector{Vector{Int64}}() for _ in 1:nb_nodes]
        for i in 3:nb_relations+2
            line = split(lines[i])
            val_start = parse(Int64, line[1])
            val_end = parse(Int64, line[2])
            weight = parse(Int64, line[3])
            push!(al[val_start], [val_end, weight])
        end
        return al
    end
end

al_from_file = read_graph(joinpath(@__DIR__, "graph.txt"))
println(al_from_file)

queue = [1]
typeof(queue)

bfs = function (graph, start)
    queue = [start]
    seen = []
    while length(queue) > 0
        node = popfirst!(queue)
        println("Exploring node $(node)")
        push!(seen, node)
        for neigbourgh in graph[node]
            if !(neigbourgh in seen)
                push!(queue, neigbourgh)
            end
        end
    end
end

println("-----BFS-----")
bfs(al, 1)

dfs = function (graph, start)
    stack = [start]
    seen = []
    while length(stack) > 0
        node = pop!(stack)
        println("Exploring node $(node)")
        push!(seen, node)
        for neigbourgh in graph[node]
            if !(neigbourgh in seen)
                push!(stack, neigbourgh)
            end
        end
    end
end

println("-----DFS-----")
dfs(al, 1)

dijkstra = function (graph, start_node, end_node)
    
    get_min_dist = function (stack, dist)
        min = typemax(Int64)
        best_node = 0
        best_index = 0
        for index in eachindex(stack)
            node = stack[index]
            if dist[node] < min
                min = dist[node]
                best_node = node
                best_index = index
            end
        end
        return best_node, best_index
    end


    dist = [ typemax(Int64) for _ in 1:length(graph)]
    stack = [i for i in 1:length(graph)]
    pred = [Vector{Int64}() for _ in 1:length(graph)]
    dist[start_node] = 0

    node = start_node
    while length(stack) > 0 & node != end_node
        node, index = get_min_dist(stack, dist)
        deleteat!(stack, index)
        for neigbourgh in graph[node]
            if dist[node] + neigbourgh[2] < dist[neigbourgh[1]]
                dist[neigbourgh[1]] = dist[node] + neigbourgh[2]
                pred[neigbourgh[1]] = copy(pred[node])
                push!(pred[neigbourgh[1]], node)
            end
        end
    end

    println("Minimun dist equal : ", dist[end_node])
    println("The best road found is :", pred[end_node])
end

println("-----Dijkstra-----")
println("----Easy graph----")
dijkstra(al_from_file, 1, 9)

println("----Hard graph----") 


bellman_ford = function (graph, start_node, end_node)

    dist = [ typemax(Int64) for _ in 1:length(graph)]
    stack = [i for i in 1:length(graph)]
    pred = [Vector{Int64}() for _ in 1:length(graph)]
    dist[start_node] = 0

    for _ in eachindex(stack)
        changement = false
        for i in eachindex(graph)
            for j in eachindex(graph[i])
                u = i
                v = graph[i][j][1]
                w = graph[i][j][2]
                if dist[u] + w < dist[v]
                    changement = true
                    dist[v] = dist[u] + w
                    pred[v] = copy(pred[u])
                    push!(pred[v], u)
                end
            end
        end
        if !changement
            break
        end
    end
    println("Minimun dist equal : ", dist[end_node])
    println("The best road found is :", pred[end_node])
end


println("-----Dijkstra-----")
println("----Easy graph----")
bellman_ford(al_from_file, 1, 9)

println("----Hard graph----") 