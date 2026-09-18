process ParseDeepRVATIntoHt {
    container params.container
    cache false

    // parse DeepRVAT data as a Hail Table
    publishDir params.processed_annotations, mode: 'copy'

    input:
        path deeprvat_tsv

    output:
        path "deeprvat.ht"

    script:
        """
        python -m talos.annotation_scripts.parse_deeprvat_into_ht \
            --deep_rvat ${deeprvat_tsv} \
            --ht_out deeprvat.ht
        """
}
