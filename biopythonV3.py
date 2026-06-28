from Bio import SeqIO
import gzip
import argparse
parser = argparse.ArgumentParser(description = "process .fastq.gz file")
parser.add_argument("filename", help = "path to file")
args = parser.parse_args()
def report (record):
    seen = set()
    for dups, record in enumerate(SeqIO.parse(record, "fastq")):
      if record.id in seen:
         continue
      elif len(seen) == 5:
         break
      else:
          seen.add(record.id)
      print(f"ID: {(record.id)} | Length: {len(record)}")
with gzip.open (args.filename, 'rt') as f:
   report(f)