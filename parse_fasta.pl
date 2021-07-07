#!/usr/bin/perl

# Outputs a CSV file of id,description for import into sqlite
#
print @ARGV;

use strict;
use warnings;
my $infile = shift || "../database_files/uniref90.fasta.gz";
my $infh;
if ($infile =~ /\.gz$/ ) {
    open($infh => "zgrep '^>' $infile |") || die "cannot open $infile w zgrep: $!";
} else {
    open($infh => "grep '^>' $infile |") || die "cannot open $infile with grep: $!";
}
while(<$infh>) {
    chomp;
    if( /^>((\S+)\s+.+)/ ) {
	print join(",", map { sprintf('"%s"',$_ ) } ($2,$1)),"\n";
    }
}
close($infh);
