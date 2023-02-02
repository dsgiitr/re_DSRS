#! /bin/bash

# Training the model
# This is for running the MNIST model

echo -n "Enter the Variance for the CIFAR model:(write with two decimals)"
read sigma

echo "Enter the training method for the CIFAR model:"
echo "(*** 1 for gaussian augmentation, 2 for consistency and 3 for smoothmix***)"
read method


# sampling for model (P sampling)
if [ $method -eq 1 ];  
then  
path=sig_models/new_cohen/cohen-cifar-1530-$sigma.pth.tar
elif [ $method -eq 2 ];  
then
path=sig_models/consistency/consistency-cifar-1530-$sigma.pth.tar
else  
path=sig_models/smoothmix/smoothmix-cifar-1530-$sigma.pth.tar 
fi 
echo $path
# training variable
if [ $method -lt 3 ];  
then  
python dsrs/train.py cifar10 cifar_resnet110 --lr 0.01 --lr_step_size 50 --epochs 150 --noise $sigma --num-noise-vec 2 --lbd 20 --k 1530 --k-warmup 100 --save_path $path
else  
python dsrs/train_smoothmix.py cifar10 cifar_resnet110 --lr 0.01 --lr_step_size 50 --epochs 150 --noise $sigma --num-noise-vec 2 --lbd 20 --k 1530 --k-warmup 100 --save_path $path
fi 

python dsrs/sampler.py cifar10 $path $sigma --disttype general-gaussian --k 380 --N 50000 --alpha 0.0005 --skip 10 --batch 400

val=$(echo $sigma 100 | awk '{printf "%4.3f\n",$1*$2}')
value=${val%.*}
# sampling for model (Q sampling)
if [ $value -eq 5 ];
then  
var_q=0.025  
elif [ $value -eq 10 ];  
then  
var_q=0.05
elif [ $value -eq 20 ];  
then  
var_q=0.1
elif [ $value -eq 25 ];  
then  
var_q=0.2
elif [ $value -eq 50 ];  
then  
var_q=0.4
else  
var_q=0.8
fi 
echo $var_q
python dsrs/sampler.py cifar10 $path $var_q --disttype general-gaussian --k 380 --N 50000 --alpha 0.0005 --skip 10 --batch 400 

# Neymen Pearson Based certification(for DSRS)
if [ $method -eq 1 ];  
then  
path=cohen-cifar-1530-$sigma
elif [ $method -eq 2 ];  
then
path=consistency-cifar-1530-$sigma
else  
path=smoothmix-cifar-1530-$sigma
fi 
python dsrs/main.py cifar10 origin $path general-gaussian --k 1530 $sigma 50000 0.0005 --workers 20

# DSRS Certification
python dsrs/main.py cifar10 improved $path general-gaussian --k 1530 $sigma 50000 0.0005 -b $var_q --workers 20
