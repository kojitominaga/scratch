#!/bin/bash

#SBATCH --job-name=firsttrial
#SBATCH --account=uio
#SBATCH --time=20:00:00

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mail-type=ALL

#SBATCH --mem-per-cpu=3G

source /cluster/bin/jobsetup
module load python2
module load R

cp /cluster/home/kojito/nora10/scripts/* $SCRATCH

export OMP_NUM_THREADS=1

cd $SCRATCH

python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2012.nc locations.csv $SCRATCH