library(DiagrammeR)

grViz("
digraph neato {
  graph[layout = circo, rankdir = LR]
  node[fontname = Arial]
  'Species richness'

  node[fontname = Arial]
  'Cultural burning'; 'Land use change'; 'Invasive species'; 'Climate damage'; 'Fire impact'

  # edge statements
  'Cultural burning'->'Species richness' 'Land use change'->'Species richness'
  'Invasive species'->'Species richness' 'Climate damage'->'Species richness' 'Fire impact'->'Species richness'

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

mermaid("
graph RL
A(Biodiversity)-->D{Safer healthier people}  
B(Higher income)-->D{Safer healthier people}  
C(Bushfire safety)-->D{Safer healthier people} 
D{Safer healthier people}-->F{Vulnerable people}
F{Vulnerable people}-->D{Safer healthier people} 
E(Water quality)-->F{Vulnerable people}
G(Wastewater disease burden)-->F{Vulnerable people}
H(Healthcare access)-->F{Vulnerable people}
I(Climate risk)-->F{Vulnerable people}
J(Lower income)-->F{Vulnerable people}
K(Road accidents)-->F{Vulnerable people}
L(Disability)-->F{Vulnerable people}


        ")

grViz("
digraph {

node [fontname = Arial]
a [label = '@@1']
b [label = '@@2']
c [lable = '@@3']
d [lable = '@@4']
e [lable = '@@5']
f [lable = '@@6']
g [lable = '@@7']
h [lable = '@@8']
i [lable = '@@9']
j [lable = '@@10']
k [lable = '@@11']
l [lable = '@@12']

c->a d->a e->a
a->b b->a
f->b g->b g->b i->b j->b k->b l->b

}

[1] 'Safer healthier people'
[2] 'Vulnerable people'
[3] 'Biodiversity'
[4] 'Higher income'
[5] 'Bushfire safety'
[6] 'Water quality'
[7] 'Wastewater disease burden'
[8] 'Healthcare access'
[9] 'Climate risk'
[10] 'Lower income'
[11] 'Road accidents'
[12] 'Disability'

")

grViz("
digraph {
  graph[layout = dot, rankdir = LR]
  node[shape = box, fontname = Arial]
  'Safer healthier people'; 'Vulnerable people'

  node[shape = oval, fontname = Arial]
  'Biodiversity'; 'Higher income'; 'Bushfire safety'; 'Water quality'; 'Wastewater disease burden';
  'Healthcare access'; 'Climate risk'; 'Lower income'; 'Road accidents'; 'Disability'

  # edge statements
  'Safer healthier people'->'Vulnerable people' 'Vulnerable people'->'Safer healthier people'
  'Wastewater disease burden'->'Vulnerable people' 'Healthcare access'->'Vulnerable people'
  'Climate risk'->'Vulnerable people' 'Lower income'->'Vulnerable people' 'Road accidents'->'Vulnerable people'
  'Disability'->'Vulnerable people' 'Water quality'->'Vulnerable people'
   'Biodiversity'->'Safer healthier people' 'Higher income'->'Safer healthier people'
  'Bushfire safety'->'Safer healthier people'
 
}
")
