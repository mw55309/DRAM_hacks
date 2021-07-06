#!/usr/bin/perl

#
# Assumes uniref90.fasta.gz is in the same directory
#
# Outputs a CSV file of id,description for import into sqlite
#

use strict;
use warnings;
my $infile= "../database_files/uniref90.fasta.gz";
open(IN, "zgrep $infile  '^>' |");
while(<IN>) {
    chomp;
    if( /^>((\S+)\s+.+)/ ) {
	print join(",", map { sprintf('"%s"',$_ ) } ($2,$1)),"\n";
    }
}
close IN;
