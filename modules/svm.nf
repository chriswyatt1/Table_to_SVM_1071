process RUN_SVM {
    label 'svm'
    publishDir "$params.outdir/" , mode: 'copy'
    //stageInMode 'copy'
    input:
        path data
        path pheno

    output:
        path '*.pdf' , emit: learning

    script:
    """
    demo.R $data $pheno	$params.condA $params.condB
    """
}