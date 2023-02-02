## General Gaussian

## Training of the model 
python dsrs/train.py cifar10 cifar_resnet110 --lr 0.01 --lr_step_size 50 --epochs 150  --noise 0.50 --pretrained-model dsrs/hamare_models_adv/pgd_adversarial_training_cifar.pth --num-noise-vec 2 --lbd 20 --k 1530 --k-warmup 100 --save_path dsrs/hamare_models_adv/cifar10_half_consistency_150_001.pth

## Neyman Pearson Certification
python dsrs/sampler_adv.py cifar10 dsrs/hamare_models_adv/cifar10_half_consistency_150_001.pth 0.50 --disttype general-gaussian --k 1530 --N 100000 --alpha 0.001 --skip 10 --batch 400 
python dsrs/main_adv.py cifar10 origin cifar10_half_consistency_150_001 general-gaussian --k 1530 0.50 100000 0.001 --workers 20

## DSRS certification
python dsrs/sampler_adv.py cifar10 dsrs/hamare_models_adv/cifar10_half_consistency_150_001.pth 0.50 --disttype general-gaussian --k 1530 --N 50000 --alpha 0.0005 --skip 10 --batch 400 
python dsrs/sampler_adv.py cifar10 dsrs/hamare_models_adv/cifar10_half_consistency_150_001.pth 0.4 --disttype general-gaussian --k 1530 --N 50000 --alpha 0.0005 --skip 10 --batch 400 
python dsrs/main_adv.py cifar10 origin cifar10_half_consistency_150_001 general-gaussian --k 1530 0.50 50000 0.0005 --workers 20
python dsrs/main_adv.py cifar10 improved cifar10_half_consistency_150_001 general-gaussian --k 1530 0.50 50000 0.0005 -b 0.4 --workers 20
