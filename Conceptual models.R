library(DiagrammeR)

grViz("
digraph circo {
  graph[layout = circo, rankdir = LR]
  node[shape = box, fontname = Arial]
  'Increase'; 'Species richness'; 'Decrease'

  node[shape = circle, fixedsize = true, width = 0.9]
  'Cultural burning'; 'Land use change'; 'Invasive species'; 'Climate damage'; 'Fire impact'

  # edge statements
  'Cultural burning'->'Increase' 'Land use change'->'Increase' 'Increase'->'Species richness' 
  'Species richness'->'Decrease'
  'Invasive species'->'Decrease' 'Climate damage'->'Decrease' 'Fire impact'->'Decrease'

}
")

mermaid("
graph LR
A(Cultural burning)-->B[SR increase]  
C(Land use change)-->B[SR increase] 
B[SR increase]-->D{Species richness}
D{Species richness}-->E[SR decrease]
F(Invasive species)-->E[SR decrease]
G(Climate damage)-->E[SR decrease]
H(Fire impact)-->E[SR decrease]
        ")
