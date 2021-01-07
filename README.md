[DRAM](https://github.com/shafferm/DRAM) is a super useful pipeline for providing a deep annotation of metagenomes and metagenome-assembled genomes (MAGs), [published in NAR](https://academic.oup.com/nar/article/48/16/8883/5884738)

An issue that I and a few others have come up against is the DRAM database. DRAM pulls in a number of public databases, including UniRef, Pfam, dbCAN2, KEGG and a few others, and uses [MMseqs2](https://github.com/soedinglab/MMseqs2) to create searchable databases. This is all fine, but as the final step, DRAM creates a SQLite database and this single step can be a killer. In our benchmarking it was planned to take:

* 8 hours on ultra-fast SSDs
* 48 hours on Lustre with a fast network
* 19 days on our HPC "fast disk" (I am unsure of the set-up, but it will be slower than Lustre)

Bear in mind that the DRAM database set-up requires at least 512Gb of RAM and recommends multiple cores.... and, given the max time for jobs on our cluster is 14 days, we were never going to finish.

What [others have suggested](https://github.com/shafferm/DRAM/issues/26#issuecomment-702656498) is to build the MMseqs2 databases on HPC, and then move everytyhing to the cloud (or to a faster disk) to write the SQLite description DB. In fact my laptop has a 1Tb SSD, but only 32Gb of RAM and it turns out that was not enough for the SQLite step. Arrrrgghhhhhhh!

So, is there another way?

Well, the DRAM description database schema is [easily discoverable](https://github.com/mw55309/DRAM_hacks/blob/main/dram_description_db_schema.sql), and for seven tables it is simply the ID and the DESCRIPTION field for each database:

dbCAN2 table:
```sh
id,description
AA0,AA0
AA10,"AA10 (formerly CBM33) proteins are copper-dependent lytic polysaccharide monooxygenases (LPMOs); some proteins have been shown to act on chitin, others on cellulose; lytic cellulose monooxygenase (C1-hydroxylating) (EC 1.14.99.54); lytic cellulose monooxygenase (C4-dehydrogenating)(EC 1.14.99.56); lytic chitin monooxygenase (EC 1.14.99.53)"
AA11,"AA11 proteins are copper-dependent lytic polysaccharide monooxygenases (LPMOs); cleavage of chitin chains with oxidation of C-1 has been demonstrated for a AA11 LPMO from Aspergillus oryzae;"
AA12,"AA12 The pyrroloquinoline quinone-dependent oxidoreductase activity was demonstrated for the CC1G_09525 protein of Coprinopsis cinerea."
```

KEGG table:
```sh
id,description
eco:b0001,"eco:b0001  thrL; thr operon leader peptide"
eco:b0034,"eco:b0034  caiF; cai operon transcriptional activator"
eco:b0068,"eco:b0068  thiB; thiamine/thiamine pyrophosphate/thiamine monophosphate ABC transporter periplasmic binding protein"
eco:b0101,"eco:b0101  yacG; DNA gyrase inhibitor"
```

MEROPs peptidase database:
```sh
id,description
MER0000001,"MER0000001 - chymotrypsin B (Homo sapiens) [S01.152]#S01A#{peptidase unit: 34-263}~source CTRB_HUMAN~"
MER0000034,"MER0000034 - trypsin Vb ({Rattus norvegicus}) (Rattus norvegicus) [S01.093]#S01A#{peptidase unit: 25-246}~source TRYB_RAT~"
MER0000066,"MER0000066 - hypodermin B (Hypoderma lineatum) [S01.090]#S01A#{peptidase unit: 31-256}~source HYPB_HYPLI~"
MER0000099,"MER0000099 - kallikrein 1-related peptidase b1 (Mus musculus) [S01.164]#S01A#{peptidase unit: 25-260}~source KLK1_MOUSE~"
```

PFam database:
```sh
id,description
PF10417.10,"C-terminal domain of 1-Cys peroxiredoxin"
PF12574.9,"120 KDa Rickettsia surface antigen"
PF09847.10,"Membrane protein of 12 TMs"
PF00244.21,"14-3-3 protein"
```

UniRef90 database:
```sh
id,description
UniRef90_A0A5A9P0L4,"UniRef90_A0A5A9P0L4 Peptidylprolyl isomerase n=1 Tax=Triplophysa tibetana TaxID=1572043 RepID=A0A5A9P0L4_9TELE"
UniRef90_G3HAC6,"UniRef90_G3HAC6 Titin n=5 Tax=Boreoeutheria TaxID=1437010 RepID=G3HAC6_CRIGR"
UniRef90_A0A0D9RKL7,"UniRef90_A0A0D9RKL7 Uncharacterized protein n=1 Tax=Chlorocebus sabaeus TaxID=60711 RepID=A0A0D9RKL7_CHLSB"
UniRef90_A0A6J1Z2E1,"UniRef90_A0A6J1Z2E1 titin isoform X1 n=3 Tax=Boreoeutheria TaxID=1437010 RepID=A0A6J1Z2E1_ACIJB"
```

UniProt Viral:
```sh
id,description
NP_943779.1,"NP_943779.1 adenylate kinase [Mycobacterium phage PG1]"
NP_943811.1,"NP_943811.1 hypothetical protein PBI_PG1_33 [Mycobacterium phage PG1]"
NP_943843.1,"NP_943843.1 hypothetical protein PBI_PG1_65 [Mycobacterium phage PG1]"
NP_943875.1,"NP_943875.1 hypothetical protein PBI_PG1_97 [Mycobacterium phage PG1]"
```

VOGDB database:
```sh
id,description
VOG00001,"sp|P03041|RPC1_BPP22 Transcriptional activator protein C1; Xu"
VOG00002,"sp|Q5UPJ9|YL122_MIMIV Putative ankyrin repeat protein L122; Xh"
VOG00003,"sp|O22001|VXIS_BPMD2 Excisionase; Xr"
VOG00004,"sp|P03795|Y28_BPT7 Protein 2.8; Xu"
```

Seems to me that producing these tables independently of DRAM should be pretty simple, and then we can work on improving the SQLite upload problem - which, in DRAM, uses SQLalchemy.

Well, in this github repo is a bunch of scripts that should provide the CSV files needed to populate the description DB schema. So the steps would be:


* __note you can't just do this on the same disk that DRAM-setup.py failed on - this would be as slow if not slower - but you _can_ move the files to an SSD, at which point the write speeds are much faster__
* __I moved the data to my Windows SurfaceBook 3 which has a Tb SSD - took about ~3 hours to load all the data__
* run DRAM-setup.py on your HPC in the usual way until it starts creating the description_db.sqlite, then kill the process
* go in to the DRAM_data directory
* clone this repository
* run the seven perl scripts to create CSV files for import
* move the CSV files and dram_description_db_schema.sql to an SSD or other ultra fast disk
* create an empty sqlite database ```sqlite3 mydescription_db.sqlite```
* create the DB schema ```.read dram_description_db_schema.sql```
* set to mode csv ```.mode csv```
* import each CSV file e.g. ```.import csvfilename tablename```


Import commands in sqlite:

```sql
.read dram_description_db_schema.sql
.mode csv
BEGIN;
.import uniref_description.csv uniref_description
.import kegg_description.csv kegg_description
.import viral_description.csv viral_description
.import vogdb_description.csv vogdb_description
.import peptidase_description.csv peptidase_description
.import dbcan_description.csv dbcan_description
.import pfam_description.csv pfam_description
END;
```
