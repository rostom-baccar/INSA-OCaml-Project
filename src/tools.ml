open Graph


(*Principe:
n_fold nous permet de faire une composition de new_node empty_graph id.
la première itération copie simplement le premier noeud de gr dans empty_graph
la deuxième copie le deuxième noeud de gr et l'ajoute à empty_graph(qui contient 1 noeud) etc
on se retrouve donc avec un graphe identique mais sans ses arcs *)
let clone_nodes (gr:'a graph) = n_fold gr new_node empty_graph 


(*Principe
e_fold nous permet de faire une composition de fun_arc et nodes, nodes étant la liste
les noeuds du graphe (graphe sans arcs) et fun_arc étant une fonction qui prend en argument
un graphe, les 2 neouds auxquels sont rattachés un arc et son cout, et retourne un graphe avec
comme nouvel arc entre les deux noeud un arc avec (f cout) *)
let gmap (gr:'a graph) f = 
let nodes = clone_nodes gr in
let fun_arc graphe id1 id2 cout = new_arc graphe id1 id2 (f cout) in
e_fold gr fun_arc nodes


(*find_arc nous renvoie le cout de l'arc entre les noeuds id1 et id2 du graphe g
et none si la fonction ne trouve pas d'arc.
s'il n'y a pas d'arc, on renvoie un nouvel arc avec n comme cout
si on trouve l'arc en question, on rajoute n à son cout*)
let add_arc g id1 id2 n =
match (find_arc g id1 id2) with
|Some cout -> new_arc g id1 id2 (n+cout)
|None -> new_arc g id1 id2 n

