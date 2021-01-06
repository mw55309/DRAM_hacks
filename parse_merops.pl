#!/usr/bin/perl

#
# Assumes merops_peptidases_nr.faa is in the same directory
#
# Outputs a CSV file of id,description for import into sqlite
#

open(IN, "cat merops_peptidases_nr.faa \| grep '>' |");
while(<IN>) {
        s/\n|\r//g;
        $line = $_;
        $line =~ s/\n|\r//g;
        $line =~ s/^>//;

        my ($id,@rest) = split(/ /, $line);

        print '"', $id, '","', $line, '"', "\n";
}
close IN;
