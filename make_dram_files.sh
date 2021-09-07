#!/usr/bin/bash

if [ ! -f uniref_description.csv ]; then
    perl DRAM_hacks/parse_fasta.pl ../database_files/uniref90.fasta.gz > uniref_description.csv
fi
if [ ! -f viral_description.csv ]; then
    perl DRAM_hacks/parse_fasta.pl ../database_files/viral.merged.protein.faa.gz > viral_description.csv
fi
if [ ! -f peptidase_description.csv ]; then
    perl DRAM_hacks/parse_fasta.pl ../database_files/merops_peptidases_nr.faa  > peptidase_description.csv
fi
if [ ! -f dbcan_description.csv ]; then
    perl DRAM_hacks/parse_cazy.pl ../CAZyDB.07302020.fam-activities.txt  > dbcan_description.csv
fi
if [ ! -f vogdb_description.csv ]; then
    perl DRAM_hacks/parse_vog.pl ../vog_annotations_latest.tsv.gz > vogdb_description.csv
fi
if [ ! -f pfam_description.csv ]; then
    perl DRAM_hacks/parse_pfam.pl  ../Pfam-A.hmm.dat.gz > pfam_description.csv
fi
