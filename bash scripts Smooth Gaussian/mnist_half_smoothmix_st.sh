python dsrs/train_smoothmix.py mnist mnist_43 --lr 0.01 --lr_step_size 30 --epochs 90 --noise_sd 0.50 --eta 5.00 --num-noise-vec 4 --num-steps 8 --mix_step 1 --save_path dsrs/hamare_models/mnist_half_smoothmix_90_001_st.pth
python dsrs/sampler.py mnist dsrs/hamare_models/mnist_half_smoothmix_90_001_st.pth 0.50 --disttype gaussian --N 50000 --alpha 0.0005 --skip 10 --batch 400
python dsrs/sampler.py mnist dsrs/hamare_models/mnist_half_smoothmix_90_001_st.pth 0.4 --disttype gaussian --N 50000 --alpha 0.0005 --skip 10 --batch 400
python dsrs/main.py mnist origin mnist_half_smoothmix_90_001_st gaussian 0.50 50000 0.0005 --workers 20
python dsrs/main.py mnist improved mnist_half_smoothmix_90_001_st gaussian 0.50 50000 0.0005 -b 0.4 --workers 20
