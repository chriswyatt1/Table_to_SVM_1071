/*
 * Copyright (c) 2021
 */
 

 /*
 * SVM in Nextflow
 *
 * Authors:
 * - Chris Wyatt <chris.wyatt@seqera.io>
 * - Ben Taylor <>
 */

/* 
 * enable modules 
 */
nextflow.enable.dsl = 2

/*
 * Default pipeline parameters (on test data). They can be overriden on the command line eg.
 * given `params.genome` specify on the run command line `--genome /path/to/Duck_genome.fasta`.
 */
params.rnaseq = "$baseDir/data/counts_clean_subsample.csv"
params.phenot = "$baseDir/data/phenotypic_data.csv"
params.condA  = "queen"
params.condB  = "worker_ctrl"
params.outdir = "results"
params.crossfold = 3
params.numFeatureTarget = 100
params.numRepeatStochasticity = 3

//For CPU and Memory of each process: see conf/optimized_processes.config

log.info """\
 S V M 
 P I P E L I N E
 ===================================
 input rnaseq data                    : ${params.rnaseq}
 phenotypic data for each sample      : ${params.phenot}
 out directory                        : ${params.outdir}
 """

//================================================================================
// Include modules
//================================================================================

include { RUN_SVM } from './modules/svm.nf'

input_rnaseq = channel
	.fromPath(params.rnaseq)
	.ifEmpty { error "Cannot find RNA-Seq file  matching: ${params.rnaseq}" }

input_phenotype = channel
	.fromPath(params.phenot)
	.ifEmpty { error "Cannot find phenotype file: ${params.phenot}" }



workflow {
    RUN_SVM ( input_rnaseq , input_phenotype )
}

workflow.onComplete {
	println ( workflow.success ? "\nDone! Open your report in your browser --> $params.outdir/report.html (if you added -with-report flag)\n" : "Hmmm .. something went wrong" )
}

