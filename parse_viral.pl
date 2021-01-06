#!/usr/bin/perl

#
# Assumes viral.merged.protein.faa.gz is in the same directory
#
# Outputs a CSV file of id,description for import into sqlite
#

open(IN, "zcat viral.merged.protein.faa.gz \| grep '>' |");
while(<IN>) {
        chomp();
        $line = $_;
        $line =~ s/^>//;

        my ($id,@rest) = split(/ /, $line);

        print '"', $id, '","', $line, '"', "\n";
}
close IN;

