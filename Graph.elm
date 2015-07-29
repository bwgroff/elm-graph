module Graph where

import Array as Ar

-- Types --
-- shoudl i jsut require LNode 5 "label" to exist in position 5 of array?
-- exposed methods can find and use node postions without exposing the underlying array methods
-- Nodes as records? {pos: Int, label: a}?

type Node nLabel
    = LNode Int nLabel -- Labeled Node
    | UNode Int

type Edge eLabel
    = LEdge ((Int, Int), eLabel) -- 
    | UEdge (Int, Int)

type alias Adj nLabel eLabel
    = List (eLabel, Node nLabel)

type Context nLabel eLabel
    = Context (Adj nLabel eLabel) (Node nLabel) (Adj nLabel eLabel)

type alias MContext nLabel eLabel
    = Maybe (Context nLabel eLabel)

--type alias UContext
--    = Maybe (List Node, Node, List Node)

type alias Graph nLabel eLabel
    = Ar.Array (Context nLabel eLabel)

type alias MDecomp nLabel eLabel
    = (MContext nLabel eLabel, Graph nLabel eLabel)

type alias Decomp nLabel eLabel
    = (Context nLabel eLabel, Graph nLabel eLabel)

type alias Path nLabel
    = List (Node nLabel)

type alias Trail nLabel eLabel
    = List (Node nLabel, Maybe Edge eLabel)

-- Methods --

emptyGraph : Graph n e
emptyGraph = Ar.fromList([])

isEmpty : Graph n e -> Bool
isEmpty g = Ar.length(g) == 0

nodeLabeled : Node labelType -> Bool
nodeLabeled n
    = case n of
        LNode _ _ -> True
        UNode _ -> False

edgeLabeled : Edge labelType -> Bool
edgeLabeled e
    = case e of
        LEdge _ -> True
        UEdge _ -> False

fromList : List (Context nLabel eLabel) -> Graph nLabel eLabel
fromList l
    = Ar.fromList l

{-- --Probably should avoid word "get"
extractNodeContext : Node nLabel -> Graph nLabel eLabel -> MDecomp nLabel eLabel
getNodeContext node graph 
    = case node of
        Node n -> graph[n]
        LNode (Node n, nLabel) -> graph[n]
        UNode (Node n, ()) -> graph[n]
--}

{--
extractAnyContext : Graph nLabel eLabel -> Decomp nLabel eLabel
--}

{--
addEdge : Edge eLabel -> Graph nLabel eLabel -> Graph nLabel eLabel
addEdge edge graph =  
    match both ends of edge 
    update those contexts
    update Graph array with those new contexts
    "return" new graph 
    --}

{--
insertContext : Context nLabel eLabel -> Graph nLabel eLabel -> Graph nLabel eLabel
insertContext context graph
    = update contexts associated with in / out edges
    update array with those contexts
    "return" new graph
--}

{-- Functions to define:
Create empty graph
isEmpty
Create graph from edge list, node list
insert context into graph
pluck (given/some) node context from graph (match)
get all (labeled) nodes
get all (labeled) edges
countNodes
nodeRange
map and fold functions over nodes / edges / labels
dfs, bfs, dijkstra, shortest path, dijkstra shortest path
All of the above should be implemented as :
graphSearch searchStepFunction graph
with seachStepFunction of type graphSearchState
graphSearchState = type alias of (graph, list/array, maybe function)

df_map df_fold, bf_map bf_fold etc? is this distinction worthwhile?
--}
