#!/bin/bash

#SBATCH --job-name=REDO
#SBATCH --account=uio
#SBATCH --time=61:00:00

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mail-type=ALL

#SBATCH --mem-per-cpu=3G

source /cluster/bin/jobsetup
module load python2
module load R

cd $SCRATCH
mkdir R

cp /cluster/home/kojito/nora10/scripts5/*.txt.bz2 .
cp /cluster/home/kojito/nora10/scripts5/*.R .
cp /cluster/home/kojito/nora10/scripts5/nora10interpmain.py .
cp /cluster/home/kojito/nora10/scripts5/checkfiles.py .
cp /cluster/home/kojito/nora10/scripts5/locations/*.csv . 
cp -R /cluster/home/kojito/R/x86_64-unknown-linux-gnu-library/3.0/intervals R/
cp -R /cluster/home/kojito/R/x86_64-unknown-linux-gnu-library/3.0/sp R/
cp -R /cluster/home/kojito/R/x86_64-unknown-linux-gnu-library/3.0/gstat R/
cp -R /cluster/software/VERSIONS/R-3.0.2/lib64/R/library/methods R/

# export OMP_NUM_THREADS=1

python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc101.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc003.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc081.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc036.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc076.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc042.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc007.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc006.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc032.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc037.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc093.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc028.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc000.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc063.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc047.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc062.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc021.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc069.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc103.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc075.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc090.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc025.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc079.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc094.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc016.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc030.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc044.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc085.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc055.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc035.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc068.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc105.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc083.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc024.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc009.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc104.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc082.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc005.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc034.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc027.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc004.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc010.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc092.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc039.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc046.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc022.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc051.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc014.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc064.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc059.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc052.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc013.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc054.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc088.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc073.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc040.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc011.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc098.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc100.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc041.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc078.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc057.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc096.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc077.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc002.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc020.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc080.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc033.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc056.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc074.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc067.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc091.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc099.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc072.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc017.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc038.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc008.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc065.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc050.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc019.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc029.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc061.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc060.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc045.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc031.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc066.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc012.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc087.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc049.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc095.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc097.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc102.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc048.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc071.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc089.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc043.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc053.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc058.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc015.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc070.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc026.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc001.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc086.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc023.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc084.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_1999.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_1999.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_1999.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_1999.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_1999.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_1999.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_1999.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_1999.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_1999.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_1999.nc loc018.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc101.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc003.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc081.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc036.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc076.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc042.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc007.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc006.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc032.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc037.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc093.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc028.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc000.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc063.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc047.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc062.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc021.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc069.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc103.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc075.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc090.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc025.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc079.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc094.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc016.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc030.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc044.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc085.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc055.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc035.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc068.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc105.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc083.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc024.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc009.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc104.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc082.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc005.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc034.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc027.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc004.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc010.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc092.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc039.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc046.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc022.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc051.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc014.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc064.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc059.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc052.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc013.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc054.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc088.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc073.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc040.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc011.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc098.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc100.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc041.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc078.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc057.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc096.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc077.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc002.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc020.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc080.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc033.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc056.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc074.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc067.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc091.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc099.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc072.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc017.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc038.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc008.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc065.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc050.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc019.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc029.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc061.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc060.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc045.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc031.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc066.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc012.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc087.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc049.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc095.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc097.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc102.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc048.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc071.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc089.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc043.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc053.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc058.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc015.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc070.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc026.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc001.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc086.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc023.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc084.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2000.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2000.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2000.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2000.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2000.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2000.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2000.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2000.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2000.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2000.nc loc018.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc101.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc003.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc081.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc036.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc076.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc042.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc007.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc006.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc032.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc037.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc093.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc028.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc000.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc063.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc047.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc062.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc021.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc069.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc103.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc075.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc090.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc025.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc079.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc094.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc016.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc030.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc044.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc085.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc055.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc035.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc068.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc105.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc083.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc024.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc009.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc104.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc082.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc005.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc034.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc027.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc004.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc010.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc092.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc039.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc046.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc022.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc051.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc014.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc064.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc059.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc052.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc013.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc054.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc088.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc073.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc040.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc011.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc098.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc100.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc041.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc078.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc057.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc096.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc077.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc002.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc020.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc080.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc033.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc056.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc074.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc067.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc091.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc099.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc072.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc017.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc038.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc008.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc065.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc050.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc019.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc029.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc061.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc060.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc045.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc031.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc066.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc012.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc087.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc049.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc095.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc097.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc102.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc048.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc071.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc089.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc043.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc053.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc058.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc015.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc070.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc026.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc001.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc086.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc023.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc084.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2001.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2001.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2001.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2001.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2001.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2001.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2001.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2001.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2001.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2001.nc loc018.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc101.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc003.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc081.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc036.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc076.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc042.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc007.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc006.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc032.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc037.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc093.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc028.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc000.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc063.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc047.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc062.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc021.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc069.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc103.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc075.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc090.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc025.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc079.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc094.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc016.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc030.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc044.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc085.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc055.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc035.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc068.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc105.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc083.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc024.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc009.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc104.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc082.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc005.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc034.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc027.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc004.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc010.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc092.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc039.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc046.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc022.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc051.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc014.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc064.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc059.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc052.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc013.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc054.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc088.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc073.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc040.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc011.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc098.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc100.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc041.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc078.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc057.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc096.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc077.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc002.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc020.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc080.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc033.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc056.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc074.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc067.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc091.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc099.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc072.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc017.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc038.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc008.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc065.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc050.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc019.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc029.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc061.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc060.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc045.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc031.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc066.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc012.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc087.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc049.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc095.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc097.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc102.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc048.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc071.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc089.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc043.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc053.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc058.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc015.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc070.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc026.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc001.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc086.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc023.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc084.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2003.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2003.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2003.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2003.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2003.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2003.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2003.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2003.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2003.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2003.nc loc018.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc101.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc003.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc081.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc036.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc076.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc042.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc007.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc006.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc032.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc037.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc093.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc028.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc000.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc063.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc047.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc062.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc021.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc069.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc103.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc075.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc090.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc025.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc079.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc094.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc016.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc030.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc044.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc085.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc055.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc035.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc068.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc105.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc083.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc024.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc009.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc104.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc082.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc005.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc034.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc027.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc004.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc010.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc092.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc039.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc046.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc022.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc051.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc014.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc064.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc059.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc052.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc013.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc054.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc088.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc073.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc040.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc011.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc098.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc100.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc041.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc078.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc057.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc096.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc077.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc002.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc020.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc080.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc033.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc056.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc074.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc067.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc091.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc099.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc072.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc017.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc038.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc008.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc065.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc050.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc019.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc029.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc061.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc060.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc045.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc031.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc066.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc012.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc087.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc049.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc095.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc097.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc102.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc048.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc071.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc089.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc043.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc053.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc058.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc015.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc070.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc026.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc001.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc086.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc023.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc084.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2004.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2004.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2004.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2004.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2004.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2004.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2004.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2004.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2004.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2004.nc loc018.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc101.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc101.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc003.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc003.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc081.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc081.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc036.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc036.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc076.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc076.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc042.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc042.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc007.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc007.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc006.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc006.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc032.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc032.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc037.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc037.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc093.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc093.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc028.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc028.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc000.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc000.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc063.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc063.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc047.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc047.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc062.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc062.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc021.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc021.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc069.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc069.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc103.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc103.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc075.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc075.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc090.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc090.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc025.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc025.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc079.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc079.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc094.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc094.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc016.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc016.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc030.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc030.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc044.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc044.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc085.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc085.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc055.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc055.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc035.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc035.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc068.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc068.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc105.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc105.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc083.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc083.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc024.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc024.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc009.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc009.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc104.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc104.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc082.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc082.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc005.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc005.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc034.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc034.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc027.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc027.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc004.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc004.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc010.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc010.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc092.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc092.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc039.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc039.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc046.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc046.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc022.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc022.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc051.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc051.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc014.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc014.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc064.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc064.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc059.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc059.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc052.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc052.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc013.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc013.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc054.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc054.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc088.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc088.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc073.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc073.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc040.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc040.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc011.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc011.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc098.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc098.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc100.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc100.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc041.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc041.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc078.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc078.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc057.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc057.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc096.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc096.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc077.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc077.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc002.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc002.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc020.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc020.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc080.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc080.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc033.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc033.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc056.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc056.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc074.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc074.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc067.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc067.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc091.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc091.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc099.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc099.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc072.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc072.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc017.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc017.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc038.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc038.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc008.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc008.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc065.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc065.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc050.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc050.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc019.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc019.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc029.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc029.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc061.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc061.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc060.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc060.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc045.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc045.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc031.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc031.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc066.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc066.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc012.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc012.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc087.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc087.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc049.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc049.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc095.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc095.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc097.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc097.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc102.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc102.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc048.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc048.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc071.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc071.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc089.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc089.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc043.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc043.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc053.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc053.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc058.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc058.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc015.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc015.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc070.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc070.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc026.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc026.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc001.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc001.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc086.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc086.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc023.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc023.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc084.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc084.csv $SCRATCH 100 mean24 
python nora10interpmain.py /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_2006.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/hur_2m/NORA10_1H_11km_hur_2m_2006.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/psl/NORA10_1H_11km_psl_2006.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ta_2m/NORA10_1H_11km_ta_2m_2006.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wss_10m/NORA10_1H_11km_wss_10m_2006.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/clt/NORA10_1H_11km_clt_2006.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_2006.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/wfds_10m/NORA10_1H_11km_wfds_10m_2006.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/rls/NORA10_1H_11km_rls_2006.nc loc018.csv $SCRATCH 100 mean24 &
python nora10interpmain.py /work/users/kojito/nora10/nc/albedo/NORA10_1H_11km_albedo_2006.nc loc018.csv $SCRATCH 100 mean24 &

