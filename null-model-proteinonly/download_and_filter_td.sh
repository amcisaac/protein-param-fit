#!/bin/bash
#SBATCH -J download_and_filter_td
#SBATCH -p standard
#SBATCH -t 4-00:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --account dmobley_lab
#SBATCH --export ALL
#SBATCH --constraint=fastscratch
#SBATCH -o download_and_filter_td.out
#SBATCH -e download_and_filter_td.err

date
hostname

source ~/.bashrc
conda activate openff-param-fit 

python ../2-curate-training-datasets.py download-torsiondrive                       \
    --protein-td-dataset     "OpenFF Protein Dipeptide 2-D TorsionDrive v2.1"       \
    --protein-td-dataset     "OpenFF Protein Capped 1-mer Sidechains v1.2"          \
    --initial-force-field    "initial-force-field.offxml"                           \
    --explicit-ring-torsions "../explicit-ring-torsions.dat"                        \
    --td-records-to-remove   "../torsiondrive-records-to-remove.dat"                \
    --additional-td-records  "../additional-torsiondrive-records.json"              \
    --cap-size               5                                                      \
    --cap-method             "pick_heavy"                                           \
    --n-processes            8                                                      \
    --output-dataset-path    "training-datasets/torsiondrive-training-dataset.json" \
    --output-smirks-path     "training-datasets/torsiondrive-training-smirks.json"  \
    --verbose













date
