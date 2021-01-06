#!/usr/bin/perl

#
# Assumes presence of ../CAZyDB.07312019.fam-activities.txt
#
# Outputs a CSV file of id,description for import into sqlite
#

open(IN, "../CAZyDB.07312019.fam-activities.txt");
while(<IN>) {
        next if m/^#/;

        chomp();

        my($id,$desc) = split(/\t/);
        $desc = $id if $desc eq "";

        $desc =~ s/^\s+//;

        print '"', $id, '","', $desc, '"', "\n";
}
close IN;
