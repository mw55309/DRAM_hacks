[DRAM](https://github.com/shafferm/DRAM) is a super useful pipeline for providing a deep annotation of metagenomes and metagenome-assembled genomes (MAGs), [published in NAR](https://academic.oup.com/nar/article/48/16/8883/5884738)

An issue that I and a few others have come up against is the DRAM database. DRAM pulls in a number of public databases, including UniRef, Pfam, dbCAN2, KEGG and a few others, and uses [MMseqs2](https://github.com/soedinglab/MMseqs2) to create searchable databases. This is all fine, but as the final step, DRAM creates a SQLite database and this single step can be a killer. In our benchmarking it was planned to take:

* 8 hours on ultra-fast SSDs
* 48 hours on Lustre with a fast network
* 19 days on our HPC "fast disk" (I am unsure of the set-up)

Now, given 
