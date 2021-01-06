#!/usr/bin/perl

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
