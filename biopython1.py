import gzip
from Bio import SeqIO
with gzip.open("SRR37176627.fastq.gz", 'rt') as f:
   for i, record in enumerate(SeqIO.parse(f, "fastq")):
      if i == 5:
         break
      print(f"ID: {record.id} | Length: {len(record)}")