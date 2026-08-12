#!/usr/bin/env bash
# Usage: ./permuteNodeLabels.sh input.dimacs > output.dimacs
# Option: SEED=x       # reproducible random permutation
# This script was created with the assistance of AI

set -euo pipefail

in="${1:-/dev/stdin}"

awk -v seed="${SEED:-}" '

# generate a random permutation of n elements
function shuffle(n){
  if (seed!="") srand(seed); else srand();
  for (i=1;i<=n;i++) A[i]=i; # start with identity
  for (i=n;i>1;i--){
    j=int(rand()*i)+1;            # Fisher–Yates
    tmp=A[i]; A[i]=A[j]; A[j]=tmp;
  }
  for (i=1;i<=n;i++) map[i]=A[i];
}

# keep comments
$1=="c" { print; next }

# generate permutation of nodes and print line with number of nodes and edges
$1=="p" && $2=="edge" {
  N=$3; M=$4;
  shuffle(N);
  print $0;
  next
}

# print edges for pemuted labels
$1=="e" {
  u=$2; v=$3;
  printf "e %d %d\n", map[u], map[v];
  next
}

# print weights for pemuted labels 
$1=="n" {
  u=$2; v=$3;
  printf "e %d %d\n", map[u], v;
  next
}

{ print }  # pass through any other lines
' "$in"

