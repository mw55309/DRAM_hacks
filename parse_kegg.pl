#!/usr/bin/perl
use warnings;
use strict;
#
# Outputs a CSV file of id,description for import into sqlite
#

# you need to provide your own KEGG!

my $kegg = shift;

open(IN, "grep '^>' $kegg |");
while(<IN>) {
	chomp;
	if (/^>((\S+)\s+.+)/ ){
	    my @row = map { sprintf('"%s"',$_) } ($1,$2);
	    print join(",",@row),"\n";
	}
}
close IN;

