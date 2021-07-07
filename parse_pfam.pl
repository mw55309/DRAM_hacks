#!/usr/bin/perl;

#
# Assumes presence of ../Pfam-A.hmm.dat.gz
#
# Outputs a CSV file of id,description for import into sqlite
#

use strict;
use warnings;

my $infile = shift || "../Pfam-A.hmm.dat.gz";

open(IN, "gzip -dc $infile |") || die "cannot open $infile: $!";

my $id = "";
my $de = "";

while(<IN>) {
    chomp;
    if (m/^#=GF\s+AC\s+(\S+)/) {
	$id = $1;
    } elsif (m/^#=GF\s+DE\s+(.*)/) {
	$de = $1;
    } elsif( m/^\/\//) {
	if ($id ne "" && $de ne "") {
	    print join(",", map { sprintf('"%s"',$_) } ( $id,$de) ), "\n";
	    $id = $de = "";
	} else {
	    warn "One or more of '$id' or '$de' is empty\n";
	    exit;
        }
    }
}

close IN;
