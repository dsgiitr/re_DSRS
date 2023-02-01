#!/bin/bash
#The bash script to vary Q value noise from 0.1 to 1.0

for num in {1..9}
do
echo 0.$num
python dsrs/sampler.py cifar10 dsrs/hamare_models/cifar10_half_consistency_150_001.pth 0.$num --disttype general-gaussian --k 1530 --N 50000 --alpha 0.0005 --skip 10 --batch 400 
python dsrs/main.py cifar10 improved cifar10_half_consistency_150_001 general-gaussian --k 1530 0.50 50000 0.0005 -b 0.$num --workers 20
done
