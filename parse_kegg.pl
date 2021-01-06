#!/usr/bin/perl

#
# Outputs a CSV file of id,description for import into sqlite
#

# you need to provide your own KEGG!
my $kegg = shift;

open(IN, "cat $kegg \| grep '>' |");
while(<IN>) {
        chomp();
        $line = $_;
        $line =~ s/^>//;

        my ($id,@rest) = split(/ /, $line);

        print '"', $id, '","', $line, '"', "\n";
}
close IN;

