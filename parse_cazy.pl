#!/usr/bin/perl

#
# Assumes presence of ../CAZyDB.07312019.fam-activities.txt
#
# Outputs a CSV file of id,description for import into sqlite
#
use strict;
use warnings;
my $infile = shift || "../CAZyDB.07312019.fam-activities.txt";

open(IN, $infile) || die "cannot open $infile: $!";
while(<IN>) {
    next if /^\#/;
    chomp;
    my($id,$desc) = split(/\t/,$_);
    $desc = $id if $desc eq "";
    
    $desc =~ s/^\s+//;
    print join(",", map { sprintf('"%s"',$_) } ($id,$desc)),"\n";
}
close IN;
