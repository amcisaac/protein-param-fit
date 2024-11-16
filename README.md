# protein-param-fit

OpenFF force field parameter fits for proteins

## Environment setup

Create the `openff-param-fit` conda environment from `conda-envs/param-fit.yaml`.
On the cluster where fits will be run, export the environment using [conda-pack](https://conda.github.io/conda-pack/) to a tarball in the top level directory.

`conda pack -n openff-param-fit -o openff-param-fit.tar.gz`

To run ForceBalance fits with NAGL charges or with PairwiseAbInitio targets, you will need to clone [this ForceBalance fork](https://github.com/chapincavender/forcebalance).
Checkout the branch `pairwise` and install locally using `pip install .` before exporting the environment using conda-pack. 

## Workflow

The top level directory contains python scripts and data files sufficient to reproduce the setup for the Null-0.0.3 force field.
Fit setup involves four steps, implemented in the top level python scripts whose file names start with the numerals 1-4.

For each new FF candidate, create a new subdirectory (or subsubdirectory).
Copy any scripts or data files that need to change from the top or existing subdirectories and make the changes in the working subdirectory.
Create a shell script that runs each of the four setup python scripts or copies output from an existing subdirectory.
Create a tarball from the ForceBalance target directory `forcebalance/targets`.

With the packed conda environment in the top level directory, create or copy batch scripts for the driver and workers, e.g. `null-model/null-driver.sbatch` and `null-worker-condo.sbatch`.
The driver script should copy ForceBalance input files to the local scratch directory and run the main ForceBalance program.
The worker script should copy and unpack the packed conda environment and then launch a single work_queue worker.
Submit the driver batch script and arrays of ~100 workers concurrently until the fit finishes.

`fit-status.sh` will print the objecive function values in each iteration by category: total objective function (Obj); TorsionDrives for protein backbones (BB), protein sidechains (SC) , and small molecules (SM); optimized geometries (Opt-Geo), and L2 regularization (Reg).
The script takes the SLURM output file as an argument.
With no arguments, the script will grab the SLURM job ID from `squeue` and operate on the associated output file.

## Manifest

- `conda-envs`. Minimal and solved conda environments.
- `library-charges`. Directory containing the derivation of library charges for protein residues.
- `1-get-initial-force-field.py`. Assembles the initial force field by combining protein library charges with Sage 2.1.
- `2-curate-training-datasets.py`. Pulls and filters QC training datasets from QCArchive and counts parameter coverage.
- `3-get-msm-parameters.py`. Obtains estimates of bond and angle parameters from the QM Hessian using the modified Seminario method.
- `4-create-forcebalance-inputs.py`. Generates input files for ForceBalance optimizations.
- `additional-torsiondrive-records.json`. TorsionDriveResultCollection containing TorsionDrive records to be appended to the training dataset.
- `explicit-ring-torsions.dat`. SMIRNOFF parameter IDs containing explicit ring bonds in proper torsions.
- `get-final-force-field.py`. Process ForceBalance output and write a toolkkit-ready OFFXML with and without covalent hydrogen bond constraints.
- `optimization-records-to-remove.dat`. QCArchive record IDs for Optimization records that cause ForceBalance errors.
- `protein-record-ids.dat`. Hard-coded list of QCArchive record IDs that correspond to protein datasets used to give protein training data different weights during parameter fits.
- `smarts-to-exclude.dat`. List of SMARTS patterns to exclude from the training dataset.
- `smiles-to-exclude.dat`. List of SMILES molecules to exclude from the training dataset.
- `torsiondrive-records-to-remove.dat`. QCArchive record IDs for TorsionDrive records that cause ForceBalance errors.

## Force field fits

- `b7s26-model`. Specific-0.0.3 that uses protein library charges, Sage and protein QC training data, and protein-specific SMIRNOFF types (7 backbone, 26 sidechain parameter types).
- `b7s26-nagl`. Setup for Specific model with NAGL charges instead of library charges. Used to copy input for b7s26-pairwise but has no parameter optimization.
- `b7s26-pairwise`. Specific-0.0.3-Pair is the Specific model with NAGL charges trained using PairwiseAbInitio targets in ForceBalance and priors targeting Amber ff14SB proper torsions.
- `b7s26-sage-pairwise`. Specific-0.0.3-Sage-Pair is the Specific model with NAGL charges trained using PairwiseAbInitio targets in ForceBalance and priors targeting Sage proper torsions.
- `null-model`. Null-0.0.3 that uses protein library charges, Sage and protein QC training data, but no protein-specific SMIRNOFF types.
- `null-nagl`. Null-0.0.3-NAGL is the Null model with NAGL charges instead of library charges.
- `null-nbamber`. Null-0.0.3-NBAmber is the Null model with Amber ff99 charges and Lennard-Jones parameters instead of library charges and Sage Lennard-Jones parameters.
- `null-pairwise`. Null-0.0.3-Pair is the Null model with NAGL charges trained using PairwiseAbInitio targets in ForceBalance.
- `null-qamber`. Null-0.0.3-QAmber is the Null model with Amber ff99 charges instead of library charges.
