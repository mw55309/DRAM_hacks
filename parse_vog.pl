#!/usr/bin/perl

#
# Assumes presence of ../vog_annotations_latest.tsv.gz
#
# Outputs a CSV file of id,description for import into sqlite
#
use strict;
use warnings;
my $infile = shift || "../vog_annotations_latest.tsv.gz";
open(IN,"gzip -dc $infile |") || die "cannot open $infile with gzip: $!";
while(<IN>) {
        next if m/^#/;
	chomp;
        my ($GroupName,$ProteinCount,$SpeciesCount,$FunctionalCategory,$ConsensusFunctionalDescription) = split(/\t/,$_);
	
        my $desc = sprintf("%s; %s",$ConsensusFunctionalDescription,$FunctionalCategory);
	print join(",", map { sprintf('"%s"', $_) } ($GroupName, $desc) ), "\n";
}
close IN;
