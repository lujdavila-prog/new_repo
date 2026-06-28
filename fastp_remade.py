from Bio import SeqIO
import numpy as np
import gzip
import argparse
parser = argparse.ArgumentParser(description = "process a fastq.gz file")
parser.add_argument ("filename", help = "path to file")
args = parser.parse_args()
def report(scores_read): 
    reads = []
    for records in SeqIO.parse(scores_read, "fastq"):
        scores = records.letter_annotations["phred_quality"]
        reads.extend(scores)
    print(np.mean(reads))
    print(np.min(reads))
    print(np.max(reads))
    print(np.std(reads))
with gzip.open(args.filename, 'rt') as scores_read:
    report(scores_read)