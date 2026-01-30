process ReformatAnnotatedVcfIntoHailTable {
    container params.container

    input:
        path vcf
        path alphamissense
        path deeprvat
        path gene_bed
        path mane

    publishDir params.cohort_output_dir

    output:
        path "${params.cohort}_annotations.ht"

    script:
        """
        set -ex

         python /s/project/cagi7/baselines/talos/src/talos/annotation_scripts/ReformatAnnotatedVcfIntoHailTable.py \
            --input ${vcf} \
            --am ${alphamissense} \
            --deeprvat ${deeprvat} \
            --gene_bed ${gene_bed} \
            --output ${params.cohort}_annotations.ht \
            --mane ${mane}
        """
}
