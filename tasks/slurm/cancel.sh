squeue -u $USER -h | awk '{print $1}' | xargs scancel -f
rm *.out