from Bio import SeqIO
import argparse
import gzip
parser = argparse.ArgumentParser(description = "process .fastq.gz files")
parser.add_argument("filename" , help = "path to file")
args = parser.parse_args()
def report(reads):
    counts = 0
    length = 0 
    for reads in SeqIO.parse(reads, "fastq"):
        if len(reads) > 0:
            counts += 1
            length += int(len(reads))
    average = length/counts
    return average
with gzip.open(args.filename, 'rt') as f:
    average_results = report(f)
    print(f"{average_results}")