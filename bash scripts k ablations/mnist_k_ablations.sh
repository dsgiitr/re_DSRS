# This is to perform the k abalations on the data models of CIFAR

for k in `seq 0 50 350`
do
echo $k
python dsrs/sampler.py mnist dsrs/hamare_models/mnist_half_consistency_150_001.pth 0.50 --disttype general-gaussian --outbase data_k/sampling --k $k --N 50000 --alpha 0.0005 --skip 10 --batch 400
python dsrs/sampler.py mnist dsrs/hamare_models/mnist_half_consistency_150_001.pth 0.4 --disttype general-gaussian --outbase data_k/sampling --k $k --sampling_dir data_k/sampling --original_rad_dir data_k/orig-radius --new_rad_dir data_k/new-radius 0.50 --N 50000 --alpha 0.0005 --skip 10 --batch 400
python dsrs/main.py mnist origin mnist_half_consistency_150_001 general-gaussian --k $k --sampling_dir data_k/sampling --original_rad_dir data_k/orig-radius --new_rad_dir data_k/new-radius 0.50 50000 0.0005 --workers 20
python dsrs/main.py mnist improved mnist_half_consistency_150_001 general-gaussian --k $k --sampling_dir data_k/sampling --original_rad_dir data_k/orig-radius --new_rad_dir data_k/new-radius 0.50 50000 0.0005 -b 0.4 --workers 20
done


for k in `seq 377 4 391`
do
echo $k

python dsrs/sampler.py mnist dsrs/hamare_models/mnist_half_consistency_150_001.pth 0.50 --disttype general-gaussian --outbase data_k/sampling --k $k --N 50000 --alpha 0.0005 --skip 10 --batch 400
python dsrs/sampler.py mnist dsrs/hamare_models/mnist_half_consistency_150_001.pth 0.4 --disttype general-gaussian --outbase data_k/sampling --k $k --sampling_dir data_k/sampling --original_rad_dir data_k/orig-radius --new_rad_dir data_k/new-radius 0.50 --N 50000 --alpha 0.0005 --skip 10 --batch 400
python dsrs/main.py mnist origin mnist_half_consistency_150_001 general-gaussian --k $k --sampling_dir data_k/sampling --original_rad_dir data_k/orig-radius --new_rad_dir data_k/new-radius 0.50 50000 0.0005 --workers 20
python dsrs/main.py mnist improved mnist_half_consistency_150_001 general-gaussian --k $k --sampling_dir data_k/sampling --original_rad_dir data_k/orig-radius --new_rad_dir data_k/new-radius 0.50 50000 0.0005 -b 0.4 --workers 20
date

done
