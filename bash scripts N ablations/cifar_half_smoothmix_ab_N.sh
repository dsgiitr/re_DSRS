#start time
echo "The number of samples in the abalation study for the project (N)"
read N
python dsrs/train_smoothmix.py cifar10 cifar_resnet110 --lr 0.1 --lr_step_size 50 --epochs 150  --noise 0.50 --num-noise-vec 2 --lbd 20 --k 1530 --k-warmup 100 --save_path dsrs/hamare_models/cifar10_half_consistency_150_001.pth
python dsrs/sampler_n.py cifar10 dsrs/hamare_models/cifar10_half_smoothmix_150_01.pth 0.50 --disttype general-gaussian --k 1530 --N $N --alpha 0.0005 --skip 10 --batch 400 
python dsrs/sampler_n.py cifar10 dsrs/hamare_models/cifar10_half_smoothmix_150_01.pth 0.4 --disttype general-gaussian --k 1530 --N $N --alpha 0.0005 --skip 10 --batch 400 
python dsrs/main.py cifar10 origin cifar10_half_smoothmix_150_01 general-gaussian --k 1530 0.50 $N 0.0005 --workers 20
python dsrs/main.py cifar10 improved cifar10_half_smoothmix_150_01 general-gaussian --k 1530 0.50 $N 0.0005 -b 0.4 --workers 20
date
