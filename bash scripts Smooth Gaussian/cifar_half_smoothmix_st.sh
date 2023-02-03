# We are now running tests for Smooth Gaussian Distribution

# Training of the Model
python dsrs/train_smoothmix.py cifar10 cifar_resnet110 --lr 0.1 --lr_step_size 50 --epochs 150 --noise_sd 0.50 --eta 5.00 --num-noise-vec 2 --num-steps 4 --alpha 1.0 --mix_step 1 --save_path dsrs/hamare_models/cifar10_half_smoothmix_150_01_st.pth

# Neyman-Pearson Test
python dsrs/sampler.py cifar10 dsrs/hamare_models/cifar10_half_smoothmix_150_01_st.pth 0.50 --disttype gaussian --N 100000 --alpha 0.001 --skip 10 --batch 400
python dsrs/main.py cifar10 origin cifar10_half_smoothmix_150_01_st gaussian 0.50 100000 0.001 --workers 20

#DSRS test
python dsrs/sampler.py cifar10 dsrs/hamare_models/cifar10_half_smoothmix_150_01_st.pth 0.50 --disttype gaussian --N 50000 --alpha 0.0005 --skip 10 --batch 400
python dsrs/sampler.py cifar10 dsrs/hamare_models/cifar10_half_smoothmix_150_01_st.pth 0.4 --disttype gaussian --N 50000 --alpha 0.0005 --skip 10 --batch 400
python dsrs/main.py cifar10 origin cifar10_half_smoothmix_150_01_st gaussian 0.50 50000 0.0005 --workers 20
python dsrs/main.py cifar10 improved cifar10_half_smoothmix_150_01_st gaussian 0.50 50000 0.0005 -b 0.4 --workers 20
