#!/usr/bin/perl;

#
# Assumes presence of ../Pfam-A.hmm.dat.gz
#
# Outputs a CSV file of id,description for import into sqlite
#

open(IN, "zcat ../Pfam-A.hmm.dat.gz |");

my $id = "";
my $de = "";

while(<IN>) {
        chomp();

        if (m/^#=GF\s+AC\s+(\S+)/) {
                $id = $1;
        }
        if (m/^#=GF\s+DE\s+(.*)/) {
                $de = $1;
        }

        if (m/^\/\//) {
                if ($id ne "" && $de ne "") {
                        print '"', $id, '","', $de, '"', "\n";
                        $id = "";
                        $de = "";
                } else {
                        warn "One or more of '$id' or '$de' is empty\n";
                        exit;
                }
        }

}

close IN;
