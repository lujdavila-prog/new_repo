# Sequencing QC Experiments

A collection of small bioinformatics experiments focused on FASTQ quality analysis, sequencing-read statistics, and workflow development.

This repository is a work in progress and is being used to explore different approaches to sequencing quality control with Python, Biopython, NumPy, and Nextflow.

## Current Experiments

### FASTQ Quality Statistics

Parses gzipped FASTQ files with Biopython and extracts PHRED quality scores to calculate basic quality statistics such as:

* Mean quality score
* Minimum quality score
* Maximum quality score
* Standard deviation

Current implementation is intended for learning and small test datasets. Future versions will explore more memory-efficient approaches for large sequencing files.

### Per-Position Quality Analysis

An experimental script exploring quality scores by read position.

The current approach:

1. Determines the shortest read in the FASTQ file.
2. Extracts PHRED quality scores from each read.
3. Truncates quality-score arrays to a common length.
4. Prepares the data for position-based statistical analysis.

The goal is to explore how sequencing quality changes across read positions and whether trends such as rate of quality decline can provide useful QC information.

Future work may include:

* Mean and median PHRED score by position
* Quality-score visualization
* Windowed or smoothed quality trends
* Rate-of-change analysis
* More memory-efficient processing of large FASTQ files

### Nextflow Workflow Experiment

A compact Nextflow DSL2 workflow combining:

* FASTP read preprocessing
* BWA alignment
* SAMtools sorting and indexing
* Alignment statistics with `samtools flagstat`

This workflow is being used to experiment with alternative pipeline structures and dataflow behavior.

## Tools

* Python
* Biopython
* NumPy
* Nextflow DSL2
* FASTP
* BWA
* SAMtools
* Docker / Singularity

## Status

This repository contains experimental and developmental code rather than a finished production pipeline. The focus is on learning, testing ideas, and improving approaches to sequencing QC and workflow design.
