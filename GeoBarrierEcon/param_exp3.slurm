#!/bin/bash  
#SBATCH --gres=gpu:1  
#SBATCH -N 1  
#SBATCH -n 32  
#SBATCH --time=12:00:00  
#SBATCH --exclusive  
#SBATCH -p sched_engaging_default
. /etc/profile.d/modules.sh
module load mit/matlab/2018a 
matlab -nodisplay -nodesktop -nosplash -r "run parameters_explored3.m"