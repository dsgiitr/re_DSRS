
# Training of the Model
python dsrs/train.py mnist mnist_43 --lr 0.01 --lr_step_size 50 --epochs 1 --noise 0.50 --num-noise-vec 2 --lbd 5 --k 380 --k-warmup 100 --save_path dsrs/hamare_models/mnist_half_consistency_10_001.pth

## Neyman Pearson certofication
python dsrs/sampler.py mnist dsrs/trained_models/consistency/consistency-mnist-380-0.50.pth.tar 0.50 --disttype general-gaussian --k 380 --N 100000 --alpha 0.001 --skip 10 --batch 400
python dsrs/main.py mnist origin mnist_half_consistency_150_001 general-gaussian --k 380 0.50 100000 0.001 --workers 20

## DSRS Certification
python dsrs/sampler.py mnist dsrs/trained_models/consistency/consistency-mnist-380-0.50.pth.tar 0.50 --disttype general-gaussian --k 380 --N 50000 --alpha 0.0005 --skip 10 --batch 400
python dsrs/sampler.py mnist dsrs/trained_models/consistency/consistency-mnist-380-0.50.pth.tar 0.4 --disttype general-gaussian --k 380 --N 50000 --alpha 0.0005 --skip 10 --batch 400
python dsrs/main.py mnist origin mnist_half_consistency_150_001 general-gaussian --k 380 0.50 50000 0.0005 --workers 20
python dsrs/main.py mnist improved mnist_half_consistency_150_001 general-gaussian --k 380 0.50 50000 0.0005 -b 0.4 --workers 20
date
