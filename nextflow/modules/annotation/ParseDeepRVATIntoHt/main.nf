
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
        python /talos/src/talos/annotation_scripts/ParseDeepRVATIntoHt.py \
            --deep_rvat ${deeprvat_tsv} \
            --ht_out deeprvat.ht
        """
}
