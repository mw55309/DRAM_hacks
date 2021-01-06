#!/usr/bin/perl

#
# Assumes uniref90.fasta.gz is in the same directory
#
# Outputs a CSV file of id,description for import into sqlite
#

open(IN, "zcat uniref90.fasta.gz \| grep '>' |");
while(<IN>) {
        chomp();
        my ($id,@rest) = split(/ /);
        $id =~ s/^>//;

        print '"', $id, '","', join(" ", @rest), '"', "\n";
}
close IN;
