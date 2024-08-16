#!/bin/bash

#SBATCH --job-name=R1binary_cut2
#SBATCH --output=./qsub_output/%j.out
#SBATCH --error=./qsub_error/%j.err
#SBATCH --mem=130G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24

if [ -e /modules/tcl/init/bash ]
then
    source /modules/tcl/init/bash
fi

module load regenie/3.0.3

cd /udd/reyqi/regenie/script_bella/pruned
mkdir -p qsub_output qsub_error

for pheno in binary_cut2; do
    label='R1'$pheno
    pth_output='./freeze.10a.merged.pass_and_fail.gtonly.minDP0'
    pth_input='/udd/reyqi/regenie/script_bella/pruned'

    regenie --step 1 --pgen $pth_input/Merged.NoICLD \
        --phenoFile $pth_input/regenie_pheno.txt \
        --covarFile $pth_input/regenie_cov.txt \
        --phenoCol $pheno \
        --covarCol age_baseline --covarCol gender --covarCol ats_packyears \
        --covarCol smokcignow --covarCol seq_ctrBin \
        --covarCol pc1 --covarCol pc7 --covarCol pc8 --covarCol pc9 --covarCol pc10 \
        --bsize 1000 \
        --out $pth_output/R1.$pheno \
        --bt --loocv --threads 24 --gz
done