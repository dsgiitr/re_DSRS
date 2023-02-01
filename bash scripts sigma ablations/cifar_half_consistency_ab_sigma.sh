#start time
echo "The number of samples in the abalation study for the project (N)"
read sigma

python dsrs/train.py cifar10 cifar_resnet110 --lr 0.01 --lr_step_size 50 --epochs 150  --noise $sigma --num-noise-vec 2 --lbd 20 --k 1530 --k-warmup 100 --save_path dsrs/hamare_models/cifar10_half_consistency_150_001_sigma_$sigma.pth
python dsrs/sampler.py cifar10 dsrs/hamare_models/cifar10_($sigma)_consistency_150_001.pth $sigma --disttype general-gaussian --k 1530 --N 50000 --alpha 0.0005 --skip 10 --batch 400 
python dsrs/sampler.py cifar10 dsrs/hamare_models/cifar10_($sigma)_consistency_150_001.pth 0.4 --disttype general-gaussian --k 1530 --N 50000 --alpha 0.0005 --skip 10 --batch 400 
python dsrs/main.py cifar10 origin cifar10_($sigma)_consistency_001 general-gaussian --k 1530 $sigma 50000 0.0005 --workers 20
python dsrs/main.py cifar10 improved cifar10_($sigma)_consistency_150_001 general-gaussian --k 1530 $sigma 50000 0.0005 -b  --workers 20
date

