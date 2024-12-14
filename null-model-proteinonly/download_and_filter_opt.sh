#!/bin/bash
#SBATCH -J download_and_filter_opt
#SBATCH -p standard
#SBATCH -t 4-00:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --account dmobley_lab
#SBATCH --export ALL
#SBATCH --constraint=fastscratch
#SBATCH -o download_and_filter_opt.out
#SBATCH -e download_and_filter_opt.err

date
hostname

source ~/.bashrc
conda activate openff-param-fit 

python ../2-curate-training-datasets.py download-optimization                      \
    --core-opt-dataset      "OpenFF Protein Capped 1-mers 3-mers Optimization Dataset v1.0" \
    --initial-force-field   "initial-force-field.offxml"                           \
    --opt-records-to-remove "../optimization-records-to-remove.dat"                \
    --max-opt-conformers    12                                                     \
    --output-dataset-path   "training-datasets/optimization-training-dataset.json" \
    --output-smirks-path    "training-datasets/optimization-training-smirks.json"  \
    --n-processes           8                                                      \
    --verbose

date
