#!/usr/bin/perl

#
# Assumes merops_peptidases_nr.faa is in the same directory
#
# Outputs a CSV file of id,description for import into sqlite
#
use strict;
use warnings;
my $infile = shift || "merops_peptidases_nr.faa";
open(IN, "grep '^>' $infile |") || die "cannot open $infile: $!";
while(<IN>) {
    s/[\n\r]//g; # strip unix/dos osx newlines
    if (/^>((\S+)\s+.+)/) {
	my ($line,$id) = ($1,$2);
	print join(",",map { sprintf('"%s"',$_); } ($id,$line)), "\n";
    }
}
close IN;
