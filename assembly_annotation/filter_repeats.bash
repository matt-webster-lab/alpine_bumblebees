#!/bin/bash

# Filtering: remove from the repeats db the repeats that correspond to proteins in the reference set.

nproc=35
transposon_db=/projects/references/databases/uniprot/2019-11/transposon/proteins.filtered.fa
basedir=/projects/annotation/bombus_balteatus_2/03-build_repeat_library
query_fa=RM_16560.TueMar241647532020/consensi.fa.classified
output=${basedir}/blastx.out

makeblastdb -in ${transposon_db} -dbtype prot
conda activate blast_2.7.1
blastx -db ${transposon_db} -query ${query_fa} -num_threads ${nproc} -out ${output}
conda deactivate

# ProtExcluder from https://github.com/NBISweden/ProtExcluder
ProtExcluder.pl ${output} ${query_fa}
