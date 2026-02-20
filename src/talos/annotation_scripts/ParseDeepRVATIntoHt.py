#! /usr/bin/env python3

"""
Parse DeepRVAT output into a Talos-compatible Hail Table.

Expected input:
- Per-variant DeepRVAT scores
- Must include chrom, pos, ref, alt, score

Output:
- Hail Table keyed by (locus, alleles)
"""

from argparse import ArgumentParser
import hail as hl


def main(deep_rvat_file: str, ht_out: str):
    hl.init()
    hl.default_reference('GRCh38')

    # Example: TSV input
    ht = hl.import_table(
        deep_rvat_file,
        types={
            'chrom': hl.tstr,
            'pos': hl.tint32,
            'ref': hl.tstr,
            'alt': hl.tstr,
            'transcript': hl.tstr,
            'deeprvat_score': hl.tfloat64,
            'deeprvat_impairment': hl.tstr,
        },
        force=True,
    )

    ht = ht.transmute(
        locus=hl.locus(ht.chrom, ht.pos),
        alleles=[ht.ref, ht.alt],
        deeprvat_score=ht.deeprvat_score,
    )

    ht = ht.key_by('locus', 'alleles')

    ht.write(ht_out, overwrite=True)
    ht.describe()


def cli_main():
    parser = ArgumentParser()
    parser.add_argument('--deep_rvat', required=True, help='DeepRVAT raw output')
    parser.add_argument('--ht_out', required=True, help='Output HT path')
    args = parser.parse_args()

    main(args.deep_rvat, args.ht_out)


if __name__ == '__main__':
    cli_main()
