#!/usr/bin/perl

#
# Assumes presence of ../vog_annotations_latest.tsv.gz
#
# Outputs a CSV file of id,description for import into sqlite
#

open(IN, "zcat ../vog_annotations_latest.tsv.gz |");
while(<IN>) {
        next if m/^#/;

        chomp();

        my($GroupName,$ProteinCount,$SpeciesCount,$FunctionalCategory,$ConsensusFunctionalDescription) = split(/\t/);

        my $desc = "$ConsensusFunctionalDescription; $FunctionalCategory";

        print '"', $GroupName, '","', $desc, '"', "\n";
}
close IN;
