nextflow.enable.dsl = 2

//---PARAMS---
params.genome = "refs/staph.ref/*.fna"
params.reads  = "SRR37176627.fastq.gz"
params.outdir = "results"

//--ALIGN AND CHECK
process FASTP {
    container 'docker://staphb/fastp:latest'
    
    input:
    tuple val(sample_id), path(reads)

    output:
    tuple val(sample_id), path("${sample_id}_cleaned.fastq.gz"), emit: reads
    path "*.{json,html}", emit: report

    script:
    """
    fastp -i ${reads} -o ${sample_id}_cleaned.fastq.gz -h ${sample_id}.html -j ${sample_id}.json
    """
}
process INDEX {
    container 'docker://staphb/bwa:latest'
    publishDir "${params.outdir}/${refs}", mode: 'copy'

    input:
    path(refs)

    output:
    path refs, emit: fna
    path "*.{amb,ann,bwt,pac,sa}", emit: files_genome
    
    script:
    """
    bwa index ${refs}
    """
}

process BWA {
    container 'docker://staphb/bwa:latest'

    input:
    path fna
    path files_genome
    tuple val(sample_id), path(cleaned_reads)

    output: 
    tuple val(sample_id), path ("*.sam"), emit: sam
  

    script:
    """
    bwa mem -t ${task.cpus} ${fna} ${cleaned_reads} > ${sample_id}.sam
    """
}

process ALIGN {
    container 'docker://staphb/samtools:latest'
    publishDir "${params.outdir}/${sample_id}", mode: 'copy', pattern: "*.{bam,bai,txt}"
    
    input:
    tuple val(sample_id), path (sam)
    
    output:
    path "*.bam", emit: bam
    path "*.bai", emit: bai
    tuple val(sample_id), path ("*.txt"), emit: check
    
    script:
    """
    samtools view -S -b "${sam}" | samtools sort -o "${sample_id}".bam
    samtools index "${sample_id}".bam
    samtools flagstat "${sample_id}".bam > ${sample_id}.txt
    """
}

workflow {
    ref_ch = channel.fromPath(params.genome).first()
    read_ch = channel.fromPath(params.reads).map { it -> [it.simpleName, it] }

    // 
    FASTP(read_ch)
    INDEX(ref_ch)
    BWA(INDEX.out.fna, INDEX.out.files_genome, FASTP.out.reads)
    ALIGN(BWA.out.sam)
}