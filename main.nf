nextflow.enable.dsl = 2

//---PARAMS---
params.genome = "refs/staph.ref/*.fna"
params.reads  = "SRR37176627.fastq.gz"
params.outdir = "results"

//--ALIGN AND CHECK
process ALIGN_AND_CHECK {
    // Docker Hub path translated for Singularity
    container 'docker://quay.io/biocontainers/mulled-v2-fe832793e59792186355883070401da06c0d86f7:9038202f5a6006e10b19688da953835e381eb9f0-0'
    publishDir "${params.outdir}/${sample_id}", mode: 'copy'

    input:
    path ref
    tuple val(sample_id), path (reads)

    output:
    path "*.bam", emit: bam
    path "*.bai", emit: bai
    path "*.{html,json,txt}", emit: stats
    
    script:
    """
    bwa index ${ref}
    fastp -i ${reads} -o ${sample_id}_cleaned.fastq.gz -h ${sample_id}_cleaned.html -j ${sample_id}_cleaned.json


    bwa mem -t 4 ${ref} ${sample_id}_cleaned.fastq.gz | samtools sort -o ${sample_id}_cleaned.bam -


    samtools index ${sample_id}_cleaned.bam


    samtools flagstat ${sample_id}_cleaned.bam > ${sample_id}_report.txt
    """
    }

//--WORKFLOW--
workflow { 
    ref_ch = channel.fromPath(params.genome)

    //list for files to be processed
    read_ch = channel.fromPath(params.reads).map {file -> [file.simpleName, file] }

    //will trigger the process for everyfile in ch
    ALIGN_AND_CHECK(ref_ch.first(),read_ch)
}