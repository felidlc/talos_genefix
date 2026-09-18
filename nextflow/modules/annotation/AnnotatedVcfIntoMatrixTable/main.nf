process AnnotatedVcfIntoMatrixTable {
    container params.container

    input:
        tuple val(cohort), path(vcf)
        path gene_bed
        path mane
        path deeprvat_ht

    output:
        tuple val(cohort), path("${vcf.simpleName}_annotations.mt")

    script:
        """
        set -euo pipefail

        python -m talos.annotation_scripts.annotated_vcf_into_matrixtable \
            --input ${vcf} \
            --gene_bed ${gene_bed} \
            --output ${vcf.simpleName}_annotations.mt \
            --mane ${mane} \
            --deeprvat_ht ${deeprvat_ht}

        # tidy up all checkpoints
        rm -r checkpoint*
        """
}
