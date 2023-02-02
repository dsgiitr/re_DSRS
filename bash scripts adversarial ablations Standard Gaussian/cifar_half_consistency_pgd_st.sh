
### Standard Gaussian

##PGD Training
# Neyman Pearson
python dsrs/sampler_adv_pgd_st.py cifar10 dsrs/hamare_models_adv/cifar10_half_consistency_150_001.pth 0.50 --disttype general-gaussian --N 100000 --alpha 0.001 --skip 10 --batch 400
python dsrs/main_adv_pgd_st.py cifar10 origin cifar10_half_consistency_150_001 general-gaussian --k 0 0.50 100000 0.001 --workers 20

# DSRS Certification
python dsrs/sampler_adv_pgd_st.py cifar10 dsrs/hamare_models_adv/cifar10_half_consistency_150_001.pth 0.50 --disttype general-gaussian --N 50000 --alpha 0.0005 --skip 10 --batch 400
python dsrs/sampler_adv_pgd_st.py cifar10 dsrs/hamare_models_adv/cifar10_half_consistency_150_001.pth 0.4 --disttype general-gaussian --N 50000 --alpha 0.0005 --skip 10 --batch 400
python dsrs/main_adv_pgd_st.py cifar10 origin cifar10_half_consistency_150_001 general-gaussian 0.50 50000 0.0005 --workers 20
python dsrs/main_adv_pgd_st.py cifar10 improved cifar10_half_consistency_150_001 general-gaussian 0.50 50000 0.0005 -b 0.4 --workers 20
