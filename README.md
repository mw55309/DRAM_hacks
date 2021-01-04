[DRAM](https://github.com/shafferm/DRAM) is a super useful pipeline for providing a deep annotation of metagenomes and metagenome-assembled genomes (MAGs), [published in NAR](https://academic.oup.com/nar/article/48/16/8883/5884738)

An issue that I and a few others have come up against is the DRAM database. DRAM pulls in a number of public databases, including UniRef, Pfam, dbCAN2, KEGG and a few others, and uses [MMseqs2](https://github.com/soedinglab/MMseqs2) to create searchable databases. This is all fine, but as the final step, DRAM creates a SQLite database and this single step can be a killer. In our benchmarking it was planned to take:

* 8 hours on ultra-fast SSDs
* 48 hours on Lustre with a fast network
* 19 days on our HPC "fast disk" (I am unsure of the set-up, but it will be slower than Lustre)

Bear in mind that the DRAM database set-up requires at least 512Gb of RAM and recommends multiple cores.... and, given the max time for jobs on our cluster is 14 days, we were never going to finish.

What [others have suggested](https://github.com/shafferm/DRAM/issues/26#issuecomment-702656498) is to build the MMseqs2 databases on HPC, and then move everytyhing to the cloud (or to a faster disk) to write the SQLite description DB. In fact my laptop has a 1Tb SSD, but only 32Gb of RAM and it turns out that was not enough for the SQLite step. Arrrrgghhhhhhh!

So, is there another way?

Well, the DRAM description database schema is [easily discoverable](https://github.com/mw55309/DRAM_hacks/blob/main/dram_description_db_schema.sql), and for seven tables it is simply the ID and the DESCRIPTION field for each database.
