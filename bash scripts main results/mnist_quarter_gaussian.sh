# Training of the Model
python dsrs/train.py mnist mnist_43 --lr 0.01 --lr_step_size 50 --epochs 150 --noise 0.25 --num-noise-vec 1 --lbd 0 --k 380 --k-warmup 100 --save_path dsrs/hamare_models/mnist_quarter_gaussian_150_001.pth

## Neyman Pearson Certification 
python dsrs/sampler.py mnist dsrs/hamare_models/mnist_quarter_gaussian_150_001.pth 0.25 --disttype general-gaussian --k 380 --N 100000 --alpha 0.001 --skip 10 --batch 400
python dsrs/main.py mnist origin mnist_quarter_gaussian_150_001 general-gaussian --k 380 0.25 100000 0.001 --workers 20

## DSRS Certification
python dsrs/sampler.py mnist dsrs/hamare_models/mnist_quarter_gaussian_150_001.pth 0.25 --disttype general-gaussian --k 380 --N 50000 --alpha 0.0005 --skip 10 --batch 400
python dsrs/sampler.py mnist dsrs/hamare_models/mnist_quarter_gaussian_150_001.pth 0.2 --disttype general-gaussian --k 380 --N 50000 --alpha 0.0005 --skip 10 --batch 400
python dsrs/main.py mnist origin mnist_quarter_gaussian_150_001 general-gaussian --k 380 0.25 50000 0.0005 --workers 20
python dsrs/main.py mnist improved mnist_quarter_gaussian_150_001 general-gaussian --k 380 0.25 50000 0.0005 -b 0.2 --workers 20
date
