python dsrs/train.py mnist mnist_43 --lr 0.01 --lr_step_size 50 --epochs 150  --noise 1.00 --num-noise-vec 2 --lbd 5 --save_path dsrs/hamare_models/mnist_one_consistency_150_001_st.pth
python dsrs/sampler.py mnist dsrs/hamare_models/mnist_one_consistency_150_001_st.pth 1.00 --disttype gaussian --N 50000 --alpha 0.0005 --skip 10 --batch 400
python dsrs/sampler.py mnist dsrs/hamare_models/mnist_one_consistency_150_001_st.pth 0.8 --disttype gaussian --N 50000 --alpha 0.0005 --skip 10 --batch 400
python dsrs/main.py mnist origin mnist_one_consistency_150_001_st gaussian 1.00 50000 0.0005 --workers 20
python dsrs/main.py mnist improved mnist_one_consistency_150_001_st gaussian 1.00 50000 0.0005 -b 0.8 --workers 20
