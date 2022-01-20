#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=10:00
#SBATCH --partition=cpa

OMP_NUM_THREADS=16 OMP_SCHEDULE=static,1 ./restore1 -i grande.ppm -o out1.ppm -b 2

OMP_NUM_THREADS=16 OMP_SCHEDULE=static,1 ./restore2 -i grande.ppm -o out2.ppm -b 2
