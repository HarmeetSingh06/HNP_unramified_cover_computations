#!/bin/bash -l
#SBATCH --output=/scratch/users/%u/%j.out
#SBATCH --time=0-24:00

d="$1"
index_start="$2"

#SBATCH --job-name=unram_$d

module load miniforge3 # load miniforge3 for python
source "$(conda info --base)/etc/profile.d/conda.sh" 
conda activate sage_nx_tf # activate virtual environment that has working sage platform

# open sage environment and in the GAP interface read our gap code
sage -gap -q <<SCR 
Read("unram.gap");
FalseUnramObstListNoSD(${d}, ${index_start});
quit;
SCR
