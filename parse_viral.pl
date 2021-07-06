#!/usr/bin/perl

#
# Assumes viral.merged.protein.faa.gz is in the same directory
#
# Outputs a CSV file of id,description for import into sqlite
#
use strict;
use warnings;
my $infile = shift || "../database_files/viral.merged.protein.faa.gz";

open(IN, "zgrep '^>' $infile |") || die "cannot open $infile: $!";
while(<IN>) {
    
        $line = $_;
        $line =~ s/^>//;

        my ($id,@rest) = split(/ /, $line);

        print '"', $id, '","', $line, '"', "\n";
}
close IN;

