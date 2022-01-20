#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=10:00
#SBATCH --partition=cpa

mpiexec -n 1 sistbf 2048
mpiexec -n 2 sistbf 2048
mpiexec -n 4 sistbf 2048
mpiexec -n 8 sistbf 2048
mpiexec -n 16 sistbf 2048
mpiexec -n 32 sistbf 2048

mpiexec -n 1 sistbf 2048
mpiexec -n 2 sistbf 2048
mpiexec -n 4 sistbf 2048
mpiexec -n 8 sistbf 2048
mpiexec -n 16 sistbf 2048
mpiexec -n 32 sistbf 2048