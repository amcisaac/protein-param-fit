#!/bin/bash


python ../1-get-initial-force-field.py                                               \
    --input-force-field          "openff_unconstrained-2.1.0.offxml"                 \
    --library-charge-force-field "../library-charges/protein-library-charges.offxml" \
    --output-force-field         "initial-force-field.offxml"

#python ../2-curate-training-datasets.py download-optimization                      \
#    --core-opt-dataset      "OpenFF Protein Capped 1-mers 3-mers Optimization Dataset v1.0" \
#    --initial-force-field   "initial-force-field.offxml"                           \
#    --opt-records-to-remove "../optimization-records-to-remove.dat"                \
#    --max-opt-conformers    12                                                     \
#    --output-dataset-path   "training-datasets/optimization-training-dataset.json" \
#    --output-smirks-path    "training-datasets/optimization-training-smirks.json"  \
#    --verbose

#python ../2-curate-training-datasets.py download-torsiondrive                       \
#    --protein-td-dataset     "OpenFF Protein Dipeptide 2-D TorsionDrive v2.1"       \
#    --protein-td-dataset     "OpenFF Protein Capped 1-mer Sidechains v1.2"          \
#    --initial-force-field    "initial-force-field.offxml"                           \
#    --explicit-ring-torsions "../explicit-ring-torsions.dat"                        \
#    --td-records-to-remove   "../torsiondrive-records-to-remove.dat"                \
#    --additional-td-records  "../additional-torsiondrive-records.json"              \
#    --cap-size               5                                                      \
#    --cap-method             "pick_heavy"                                           \
#    --n-processes            8                                                      \
#    --output-dataset-path    "training-datasets/torsiondrive-training-dataset.json" \
#    --output-smirks-path     "training-datasets/torsiondrive-training-smirks.json"  \
#    --verbose

#python ../3-get-msm-parameters.py                                                 \
#    --initial-force-field  "initial-force-field.offxml"                           \
#    --output-force-field   "msm-force-field.offxml"                               \
#    --optimization-dataset "training-datasets/optimization-training-dataset.json" \
#    --working-directory    "modified-seminario-method"                            \
#    --verbose

#python ../4-create-forcebalance-inputs.py                                              \
#    --tag                       "tmp-forcebalance"                                     \
#    --force-field-path          "tmp-msm-force-field.offxml"                           \
#    --optimization-dataset-path "training-datasets/optimization-training-dataset.json" \
#    --torsiondrive-dataset-path "training-datasets/torsiondrive-training-dataset.json" \
#    --valence-smirks-path       "training-datasets/optimization-training-smirks.json"  \
#    --torsion-smirks-path       "training-datasets/torsiondrive-training-smirks.json"  \
#    --smarts-to-exclude         "../smarts-to-exclude.dat"                             \
#    --smiles-to-exclude         "../smiles-to-exclude.dat"                             \
#    --protein-record-ids-path   "../protein-record-ids.dat"                            \
#    --opt-geo-weight            0.005                                                  \
#    --protein-torsiondrive-weight 10.0                                                 \
#    --port                      55125                                                  \
#    --verbose

