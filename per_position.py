from Bio import SeqIO
import numpy as np
import gzip
import argparse
parser = argparse.ArgumentParser(description = "process .gz file")
parser.add_argument ("filename", help = "path to file")
args = parser.parse_args()
def report(reads):
    min_length = float('inf')
    for records in SeqIO.parse(reads, "fastq"):
        read_length = len(records)
        min_length = min(min_length, read_length)
    return min_length
with gzip.open(args.filename, 'rt') as reads:
    min_read_lengths = report(reads)
    print(min_read_lengths)
    
def positions(reads, min_read_lengths):
    new_lengths = []
    for records in SeqIO.parse(reads, "fastq"):
        scores = records.letter_annotations["phred_quality"]
        first_one = scores[:min_read_lengths]
        new_lengths.append(first_one)
    return new_lengths
with gzip.open(args.filename, 'rt') as reads:
    new_cut_lengths = positions(reads, min_read_lengths)
    print(new_cut_lengths)