#! /bin/bash

# Training the model
# This is for running the MNIST model

echo -n "Enter the Variance for the MNIST model:(write with two decimals)"
read sigma

echo "Enter the training method for the MNIST model:"
echo "(*** 1 for gaussian augmentation, 2 for consistency and 3 for smoothmix***)"
read method

# training variable
if [ $method -lt 3 ];  
then  
python train.py mnist mnist_43 --lr 0.01 --lr_step_size 50 --epochs 150 --noise $sigma --num-noise-vec 1 --lbd 0 --k 380 --k-warmup 100
else  
python train_smoothmix.py mnist mnist_43 --lr 0.01 --lr_step_size 50 --epochs 150 --noise $sigma --num-noise-vec 1 --lbd 0 --k 380 --k-warmup 100
fi 

# sampling for model (P sampling)
if [ $method -eq 1 ];  
then  
path=models/new_cohen/cohen-mnist-380-$sigma.pth.tar
elif [ $method -eq 2 ];  
then
path=models/consistency/consistency-mnist-380-$sigma.pth.tar
else  
path=models/smoothmix/smoothmix-mnist-380-$sigma.pth.tar 
fi 
python sampler.py mnist $path $sigma --disttype general-gaussian --k 380 --N 50000 --alpha 0.0005 --skip 10 --batch 400

val=$(echo $sigma 100 | awk '{printf "%4.3f\n",$1*$2}')
value=${val%.*}
# sampling for model (Q sampling)
if [ $value -eq 25 ];
then  
var_q=0.2
elif [ $value -eq 50 ];  
then  
var_q=0.4
else  
var_q=0.8
fi 

python sampler.py mnist $path $var_q --disttype general-gaussian --k 380 --N 50000 --alpha 0.0005 --skip 10 --batch 400 

# Neymen Pearson Based certification(for DSRS)
if [ $method -eq 1 ];  
then  
path=cohen-mnist-380-$sigma.pth.tar
elif [ $method -eq 2 ];  
then
path=consistency-mnist-380-$sigma.pth.tar
else  
path=smoothmix-mnist-380-$sigma.pth.tar 
fi 
python main.py mnist origin $path general-gaussian --k 380 $sigma 50000 0.0005 --workers 20

# DSRS Certification
python main.py mnist improved $path general-gaussian --k 380 $sigma 50000 0.0005 -b 0.2--workers 20