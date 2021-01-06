#!/usr/bin/perl

#
# Assumes uniref90.fasta.gz is in the same directory
#
# Outputs a CSV file of id,description for import into sqlite
#

open(IN, "zcat uniref90.fasta.gz \| grep '>' |");
while(<IN>) {
        chomp();
        $line = $_;
        $line =~ s/^>//;

        my ($id,@rest) = split(/ /, $line);

        print '"', $id, '","', $line, '"', "\n";
}
close IN;
