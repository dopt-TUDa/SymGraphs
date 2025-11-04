# This script generates Johnson (Kneser) graphs in DIMACS format.
#
# Consider a ground set of size v and let d be integral with 1 \leq d
# \leq v/2. The nodes of the Johnson graph J(v, d, q) are the subsets
# of the groundset of size d. Two nodes are adjacent if the
# corresponding sets have q elements in common. The graph J(v, d, d −
# 1) is known as the Johnson graph J(v, d) and J(v, d, 0) is known as
# the Kneser graph K(v, d).
#
# Author: Marc Pfetsch

use Algorithm::ChooseSubsets;

my $narg = @ARGV;
if ( $narg != 3 )
{
   printf("usage: <.> <v> <d> <q> (groundset size v, set size d, q elements in common)\n");
   exit(1);
}

my $v = $ARGV[0];
my $d = $ARGV[1];
my $q = $ARGV[2];

# Choose subsets of a fixed size $k
my $S = new Algorithm::ChooseSubsets($v, $d);

# compute number of nodes
my $nnodes = 0;
my @C;
while (my $x = $S->next)
{
   push(@C, $x);
   ++$nnodes;
}

#for (my $i = 0; $i < $nnodes; ++$i)
#{
#   my $x = $C[$i];
#   print @$x;
#   printf("\n");
#}

# compute number of edges
my $nedges = 0;
for (my $i = 0; $i < $nnodes; ++$i)
{
   my $x = $C[$i];
   for (my $j = $i + 1; $j < $nnodes; ++$j)
   {
      my $y = $C[$j];
      my $c = 0;
      my $s = 0;
      my $t = 0;

      while ( $s < $d && $t < $d )
      {
	 while ( $s < $d && @$x[$s] < @$y[$t] )
	 {
	    ++$s;
	 }
	 while ( $s < $d && $t < $d && @$x[$s] > @$y[$t] )
	 {
	    ++$t;
	 }
	 while ( $s < $d && $t < $d && @$x[$s] == @$y[$t] )
	 {
	    ++$c;
	    ++$s;
	    ++$t;
	 }
      }
      if ( $c == $q )
      {
	 ++$nedges;
      }
   }
}

# now write graph
printf("p edge %d %d\n", $nnodes, $nedges);
for (my $i = 0; $i < $nnodes; ++$i)
{
   my $x = $C[$i];
   for (my $j = $i + 1; $j < $nnodes; ++$j)
   {
      my $y = $C[$j];
      my $c = 0;
      my $s = 0;
      my $t = 0;

      while ( $s < $d && $t < $d )
      {
	 while ( $s < $d && @$x[$s] < @$y[$t] )
	 {
	    ++$s;
	 }
	 while ( $s < $d && $t < $d && @$x[$s] > @$y[$t] )
	 {
	    ++$t;
	 }
	 while ( $s < $d && $t < $d && @$x[$s] == @$y[$t] )
	 {
	    ++$c;
	    ++$s;
	    ++$t;
	 }
      }
      if ( $c == $q )
      {
	 # DIMACS starts with 1
	 printf("e %d %d\n", $i + 1, $j + 1);
	 ++$nedges;
      }
   }
}
