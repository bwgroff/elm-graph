import Html exposing (div, button, text)
import Html.Events exposing (onClick)
import StartApp
import Graph as G
import Array as Ar

main =
  StartApp.start { model = model, view = view, update = \g->g }


node1 = G.LNode 1 "node1"
adj1 = [("edge1", node2)]
ctxt1 = G.Context [] node1 adj1

node2 = G.LNode 2 "node2"
adj2 = [("edge1", node1)]
ctxt2 = G.Context adj2 node2 []

model = G.fromList [ctxt1, ctxt2]

nodeName : G.Context String e -> String
nodeName ctxt
    = case ctxt of
        G.Context _ node _ 
            -> case node of
                G.LNode _ label 
                    -> label
                G.UNode _ 
                    -> ""


getAdj : G.Context a b -> List (b, G.Node a)
getAdj c
    = case c of
        G.Context _ _ a -> a


adjName : G.Context String a -> String
adjName ctxt
    = getAdj ctxt |> List.map (\(a, b) -> b) |> List.map toString |> toString


graphNames : G.Graph String e -> List (String, String)
graphNames g
    = Ar.map (\c->(nodeName c, adjName c)) g |> Ar.toList

view address model =
  div []
    [ graphNames model |> toString |> text ]

