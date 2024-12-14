#!/bin/bash
#SBATCH -J fb_input
#SBATCH -p standard
#SBATCH -t 1-00:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --account dmobley_lab
#SBATCH --export ALL
#SBATCH --constraint=fastscratch
#SBATCH -o fb_input.out
#SBATCH -e fb_input.err

date
hostname

source ~/.bashrc
conda activate openff-param-fit


python ../4-create-forcebalance-inputs.py                                              \
    --tag                       "forcebalance"                                     \
    --force-field-path          "msm-force-field.offxml"                           \
    --optimization-dataset-path "training-datasets/optimization-training-dataset.json" \
    --torsiondrive-dataset-path "training-datasets/torsiondrive-training-dataset.json" \
    --valence-smirks-path       "training-datasets/optimization-training-smirks.json"  \
    --torsion-smirks-path       "training-datasets/torsiondrive-training-smirks.json"  \
    --smarts-to-exclude         "../smarts-to-exclude.dat"                             \
    --smiles-to-exclude         "../smiles-to-exclude.dat"                             \
    --protein-record-ids-path   "../protein-record-ids.dat"                            \
    --opt-geo-weight            0.005                                                  \
    --protein-torsiondrive-weight 5.0                                                 \
    --port                      55125                                                  \
    --verbose
