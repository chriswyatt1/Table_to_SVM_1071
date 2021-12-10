process RUN_SVM {
    label 'svm'
    publishDir "$params.outdir/"
    //stageInMode 'copy'
    input:
        path data
        path pheno

    output:
        path '*.pdf' , emit: learning

    script:
    """
    demo.R $data $pheno	
    """
}