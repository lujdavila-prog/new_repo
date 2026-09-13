# Sequencing QC Experiments

A small collection of Python/Biopython experiments focused on FASTQ quality analysis and sequencing-read quality-control concepts.

This repository is intentionally exploratory. The goal is to better understand how sequencing quality metrics are calculated and represented rather than to replace established production QC tools.

## fastq_quality_stats.py

### Purpose

A lightweight Python/Biopython utility created as a learning exercise to reproduce a small subset of sequencing-quality functionality found in tools such as FASTP.

The goal was to understand how PHRED quality scores can be extracted directly from FASTQ records and summarized in Python instead of relying only on the finished output of an existing QC tool.

### Current Functionality

The script parses gzipped FASTQ files and calculates:

* Mean PHRED quality score
* Minimum PHRED quality score
* Maximum PHRED quality score
* Standard deviation of PHRED quality scores

### Limitations

* Calculates only basic global PHRED-score statistics.
* Stores extracted PHRED scores in memory, so it is not optimized for very large FASTQ datasets.
* Does not perform adapter trimming, read filtering, or sequence correction.
* Does not currently generate visualizations or HTML reports.
* Assumes gzipped FASTQ input.
* Has limited input validation and error handling.

### Future Work

Possible improvements include:

* More memory-efficient quality-score processing
* Improved input validation and error handling
* Structured or labeled output
* Additional sequencing-QC statistics
* Integration with per-position quality analysis

---

## per_position.py

### Purpose

An experimental script exploring how PHRED quality scores change across read positions.

This project grew out of thinking about sequencing-read length and quality as values that could be visualized and analyzed across position. The longer-term question is whether patterns such as the rate of quality decline across a read could provide useful information about sequencing quality.

### Current Functionality

The current implementation:

1. Parses a gzipped FASTQ file with Biopython.
2. Determines the length of the shortest read.
3. Extracts PHRED quality scores from each read.
4. Truncates each quality-score array to the shortest read length.
5. Stores the resulting position-aligned quality-score arrays for further analysis.

This creates a common positional structure that can be used to compare quality scores across reads.

### Limitations

* The current implementation is incomplete and does not yet calculate per-position summary statistics.
* Truncating all reads to the shortest read length can discard useful information from longer reads.
* A single unusually short read can substantially reduce the amount of sequence data included in the analysis.
* Quality-score arrays are stored in memory, limiting scalability for large FASTQ datasets.
* The script currently prints intermediate data rather than generating a useful QC report.
* Empty or malformed input files are not yet handled robustly.

### Future Work

The next stages of the experiment may include:

* Mean and median PHRED score by read position
* Plotting quality score versus read position
* Windowed or smoothed quality trends
* Exploring first-order rate of change in per-position quality
* Investigating whether changes in quality slope identify regions of rapid quality deterioration
* Preserving information from variable-length reads without truncating all reads to the shortest sequence
* More memory-efficient processing for large FASTQ datasets

## Tools

* Python
* Biopython
* NumPy

## Status

This repository contains experimental and developmental code rather than production-ready sequencing-QC software.

The focus is on understanding FASTQ quality data, testing analytical ideas, and improving both the biological interpretation and computational implementation over time.

