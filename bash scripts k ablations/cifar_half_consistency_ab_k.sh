#start time
echo "The value of k ( d/2 -15 <= k < d/2 as per the paper) in the abalation study for the project (k)"
read k
python dsrs/train.py cifar10 cifar_resnet110 --lr 0.01 --lr_step_size 50 --epochs 150  --noise 0.50 --num-noise-vec 2 --lbd 20 --k $k --k-warmup 100 --save_path dsrs/hamare_models/cifar10_half_consistency_150_001_k_$k.pth
python dsrs/sampler.py cifar10 dsrs/hamare_models/cifar10_half_consistency_150_001_k_$k.pth 0.50 --disttype general-gaussian --k $k --N 50000 --alpha 0.0005 --skip 10 --batch 400 
python dsrs/sampler.py cifar10 dsrs/hamare_models/cifar10_half_consistency_150_001_k_$k.pth 0.4 --disttype general-gaussian --k $k --N 50000 --alpha 0.0005 --skip 10 --batch 400 
python dsrs/main.py cifar10 origin cifar10_half_consistency_150_001_k_$k general-gaussian --k $k 0.50 50000 0.0005 --workers 20
python dsrs/main.py cifar10 improved cifar10_half_consistency_150_001_k_$k general-gaussian --k $k 0.50 50000 0.0005 -b 0.4 --workers 20
date

