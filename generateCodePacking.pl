# This script generates a stable set instance in DIMACS format that
# corresponds to packing binary code words w.r.t. the Hamming
# distance.
#
# Author: Marc Pfetsch

my $narg = @ARGV;
if ( $narg != 2 )
{
   printf("usage: <.> <n> <d>  (dimension n and distance d)\n");
   exit(1);
}

my $n = $ARGV[0];
my $d = $ARGV[1];

# total number of points
my $npoints = 2 ** $n;

my $nedges = 0;
for (my $i = 0; $i < $npoints; ++$i)
{
   for (my $j = $i + 1; $j < $npoints; ++$j)
   {
      # compute hamming distance betwen points
      my $h = 0;
      for (my $k = 0; $k < $n; ++$k)
      {
	 my $b = 1 << $k;
	 if ( ($i & $b) != ($j & $b) )
	 {
	    ++$h;
	 }
      }
      
      # we have an edge if the distance between the points is at most d
      if ( $h <= $d )
      {
	 ++$nedges;
      }
   }
}

# now write graph
printf("p edge %d %d\n", $npoints, $nedges);
for (my $i = 0; $i < $npoints; ++$i)
{
   for (my $j = $i + 1; $j < $npoints; ++$j)
   {
      # compute hamming distance betwen points
      my $h = 0;
      for (my $k = 0; $k < $n; ++$k)
      {
	 my $b = 1 << $k;
	 if ( ($i & $b) != ($j & $b) )
	 {
	    ++$h;
	 }
      }
      
      # we have an edge if the distance between the points is at most d
      if ( $h <= $d )
      {
	 printf("e %d %d\n", $i + 1, $j + 1);
      }
   }
}
