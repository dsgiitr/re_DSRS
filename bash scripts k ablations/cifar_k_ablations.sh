
# This is to perform the k abalations on the data models of CIFAR

for k in `seq 0 200 1530`
do
echo $k
python dsrs/sampler.py cifar10 dsrs/hamare_models/cifar10_half_consistency_150_001.pth 0.50 --disttype general-gaussian --outbase data_k/sampling --k $k --N 50000 --alpha 0.0005 --skip 10 --batch 400
python dsrs/sampler.py cifar10 dsrs/hamare_models/cifar10_half_consistency_150_001.pth 0.4 --disttype general-gaussian --outbase data_k/sampling --k $k --N 50000 --alpha 0.0005 --skip 10 --batch 400
python dsrs/main.py cifar10 origin cifar10_half_consistency_150_001 general-gaussian --k $k --sampling_dir data_k/sampling --original_rad_dir data_k/orig-radius --new_rad_dir data_k/new-radius 0.50 50000 0.0005 --workers 20
python dsrs/main.py cifar10 improved cifar10_half_consistency_150_001 general-gaussian --k $k --sampling_dir data_k/sampling --original_rad_dir data_k/orig-radius --new_rad_dir data_k/new-radius 0.50 50000 0.0005 -b 0.4 --workers 20
done


for k in `seq 1521 4 1536`
do
echo $k
python dsrs/sampler.py cifar10 dsrs/hamare_models/cifar10_half_consistency_150_001.pth 0.50 --disttype general-gaussian --outbase data_k/sampling --k $k --N 50000 --alpha 0.0005 --skip 10 --batch 400
python dsrs/sampler.py cifar10 dsrs/hamare_models/cifar10_half_consistency_150_001.pth 0.4 --disttype general-gaussian --outbase data_k/sampling --k $k --N 50000 --alpha 0.0005 --skip 10 --batch 400
python dsrs/main.py cifar10 origin cifar10_half_consistency_150_001 general-gaussian --k $k --sampling_dir data_k/sampling --original_rad_dir data_k/orig-radius --new_rad_dir data_k/new-radius 0.50 50000 0.0005 --workers 20
python dsrs/main.py cifar10 improved cifar10_half_consistency_150_001 general-gaussian --k $k --sampling_dir data_k/sampling --original_rad_dir data_k/orig-radius --new_rad_dir data_k/new-radius 0.50 50000 0.0005 -b 0.4 --workers 20
done
