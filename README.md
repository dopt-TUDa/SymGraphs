# SymGraphs
Collection of Johnson graphs and binary code instances.

The perl script generateJohnsonGraphs.pl generates Johnson (Kneser) graphs in DIMACS format.
For a ground set of size $v$ one can select an integral $d$ with $1 \leq d \leq v/2$. The nodes of the Johnson graph $J(v, d, q)$ are the subsets of the groundset of size $d$. Two nodes are adjacent if the corresponding sets have $q$ elements in common. The graph $J(v, d, d − 1)$ is known as the Johnson graph $J(v, d)$ and $J(v, d, 0)$ is known as the Kneser graph $K(v, d)$.
The 62 instances in the directory JohnsonGraphs were generated using this script.

The perl script generateCodePacking.pl generates stable set instances arising from coding theory in DIMACS format.
Nodes of the binary-code graph $B(n,d)$ are binary code words of length $n$. Two nodes are adjacent if their Hamming distance is at most $d$.
The 23 instances in the directory BinaryCodeGraphs were generated using this script.

The Instances of each type were selected as follows:
All instances with at least 100 and at most 10000 nodes and 1000 to 1000000 edges were generated.
We ran the stable set solver BACS (https://github.com/dopt-TUDa/bacs) on all these generated instances in default-mode without SCIP symmetry handling.
Finally we eliminated all very easy (solvable in the root or in less than 10 seconds) and very hard (gap between primal and dual bound over 200 \% after running BACS for 1 hour) instances.

