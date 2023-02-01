#Training of Model
 python dsrs/train.py cifar10 cifar_resnet110 --lr 0.01 --lr_step_size 50 --epochs 150  --noise 0.25 --num-noise-vec 2 --lbd 20 --k 1530 --k-warmup 100 --save_path dsrs/hamare_models/cifar10_quarter_consistency_150_001.pth

 ## Neyman Pearson Certification
 python dsrs/sampler.py cifar10 dsrs/hamare_models/cifar10_quarter_consistency_150_001.pth 0.25 --disttype general-gaussian --k 1530 --N 100000 --alpha 0.001 --skip 10 --batch 400 
 python dsrs/main.py cifar10 origin cifar10_quarter_consistency_150_001 general-gaussian --k 1530 0.25 100000 0.001 --workers 20

 ## DSRS Certification
 python dsrs/sampler.py cifar10 dsrs/hamare_models/cifar10_quarter_consistency_150_001.pth 0.25 --disttype general-gaussian --k 1530 --N 50000 --alpha 0.0005 --skip 10 --batch 400 
 python dsrs/sampler.py cifar10 dsrs/hamare_models/cifar10_quarter_consistency_150_001.pth 0.2 --disttype general-gaussian --k 1530 --N 50000 --alpha 0.0005 --skip 10 --batch 400 
 python dsrs/main.py cifar10 origin cifar10_quarter_consistency_150_001 general-gaussian --k 1530 0.25 50000 0.0005 --workers 20
 python dsrs/main.py cifar10 improved cifar10_quarter_consistency_150_001 general-gaussian --k 1530 0.25 50000 0.0005 -b 0.2 --workers 20
 date