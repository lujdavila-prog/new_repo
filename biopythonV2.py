import gzip
from Bio import SeqIO
seen = set()
with gzip.open ("SRR37176627.fastq.gz", 'rt') as f:
   for dups, record in enumerate(SeqIO.parse(f, "fastq")):
      if record.id in seen:
         continue
      elif len(seen) == 5:
         break
      else:
          seen.add(record.id)
      print(f"ID: {(record.id)} | Length: {len(record)}")