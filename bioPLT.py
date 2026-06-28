from Bio import SeqIO
import argparse
import gzip 
parser = argparse.ArgumentParser(description = "process .fastq.gz files")
parser.add_argument("filename", help = "path to file")
args = parser.parse_args()
def report(reads):
    record_150 = 0
    over_150 = 0
    for reads in SeqIO.parse(reads, "fastq"):
        if len(reads) < 150:
            record_150 += 1
        elif len(reads) == 150:
            record_150 += 1
        else:
            over_150 += 1
    return record_150, over_150
with gzip.open(args.filename, 'rt') as f:
    result_record, result_over = report(f)
    print(f"{result_record}")
    print(f"{result_over}")
