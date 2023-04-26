#python generate_synth.py --checkpoints_dir /home/otto.tavares/public/iltbi/rxpixp2pixcycle/checkpoints/  --results_dir /home/otto.tavares/public/iltbi/rxpixp2pixcycle/versions/v1/user.otavares.cycle.shenzhenSantaCasa.v1_BtoA.r1/1aPRODUCAO/  --dataroot /home/brics/public/brics_data/Shenzhen --dataset_download_dir /home/otto.tavares/public/iltbi/train/images --download_imgs --custom_images_path /home/brics/public/brics_data/Shenzhen/raw/images --model test2cycle --direction BtoA --netG resnet_9blocks  --dataset_mode cyclesantacasaskfold2generator --token b16fe0fc92088c4840a98160f3848839e68b1148 --n_folds 10 --preprocess resize_and_scale_width --no_dropout --gpu_ids 0 --name genkl --isTB --gen_test #--gen_train_dataset

export MODELS='/home/brics/public/brics_data/Manaus/manaus/models/user.otto.tavares.Manaus_manaus.cycle_v1.r1/'
#A to B - Entra Santa Casa e sai Manaus TB
python ./generate.py --checkpoints_dir $MODELS --results_dir fake_images_SantaCasa_Manaus --gpu_ids 0 --dataset_mode  cyclemanausskfold2generator --token b16fe0fc92088c4840a98160f3848839e68b1148 --dataroot /home/brics/public/brics_data/SantaCasa/imageamento_anonimizado_valid/raw/images/ --model test2cycle --n_folds 10 --preprocess resize_and_scale_width  --norm instance --direction AtoB --netG resnet_9blocks --gen_train_dataset --n_folds 10 --no_dropout --name genkl --isTB --dataset_download_dir $PWD/images
python ./generate.py --checkpoints_dir $MODELS --results_dir fake_images_SantaCasa_Manaus --gpu_ids 0 --dataset_mode  cyclemanausskfold2generator --token b16fe0fc92088c4840a98160f3848839e68b1148 --dataroot /home/brics/public/brics_data/SantaCasa/imageamento_anonimizado_valid/raw/images/ --model test2cycle --n_folds 10 --preprocess resize_and_scale_width  --norm instance --direction AtoB --netG resnet_9blocks --gen_val_dataset --n_folds 10 --no_dropout --name genkl --isTB --dataset_download_dir $PWD/images
python ./generate.py --checkpoints_dir $MODELS --results_dir fake_images_SantaCasa_Manaus --gpu_ids 0 --dataset_mode  cyclemanausskfold2generator --token b16fe0fc92088c4840a98160f3848839e68b1148 --dataroot /home/brics/public/brics_data/SantaCasa/imageamento_anonimizado_valid/raw/images/ --model test2cycle --n_folds 10 --preprocess resize_and_scale_width  --norm instance --direction AtoB --netG resnet_9blocks --gen_test_dataset --n_folds 10 --no_dropout --name genkl --isTB --dataset_download_dir $PWD/images


#
##B to A - Entra Manaus TB sai Santa Casa
#python ./generate.py --checkpoints_dir $MODELS  --results_dir fake_images_Manaus_SantaCasa --dataset_mode  cyclemanausskfold2generator --token b16fe0fc92088c4840a98160f3848839e68b1148 --dataroot /home/brics/public/brics_data/SantaCasa/imageamento_anonimizado_valid/raw/ --model test2cycle --n_folds 10 --preprocess resize_and_scale_width  --direction BtoA --netG resnet_9blocks --norm batch  --gpu_ids -1 --gen_train_dataset --n_folds 10 --no_dropout --name genkl --isTB --dataset_download_dir $PWD/images
#python ./generate.py --checkpoints_dir $MODELS  --results_dir fake_images_Manaus_SantaCasa --dataset_mode  cyclemanausskfold2generator --token b16fe0fc92088c4840a98160f3848839e68b1148 --dataroot /home/brics/public/brics_data/SantaCasa/imageamento_anonimizado_valid/raw/ --model test2cycle --n_folds 10 --preprocess resize_and_scale_width  --direction BtoA --netG resnet_9blocks --norm batch  --gpu_ids -1 --gen_val_dataset --n_folds 10 --no_dropout --name genkl --isTB --dataset_download_dir $PWD/images
#python ./generate.py --checkpoints_dir $MODELS  --results_dir fake_images_Manaus_SantaCasa --dataset_mode  cyclemanausskfold2generator --token b16fe0fc92088c4840a98160f3848839e68b1148 --dataroot /home/brics/public/brics_data/SantaCasa/imageamento_anonimizado_valid/raw/ --model test2cycle --n_folds 10 --preprocess resize_and_scale_width  --direction BtoA --netG resnet_9blocks --norm batch  --gpu_ids -1 --gen_test_dataset --n_folds 10 --no_dropout --name genkl --isTB --dataset_download_dir $PWD/images
#
#
#mv fake_images_SantaCasa_Manaus/results .
#mv results user.otto.tavares.task.Manaus.manaus.cycle_v1.notb.r2.SantaCasa_to_Manaus.samples

#rm -rf fake_images_SantaCasa_Shenzhen
#
#mv fake_images_Manaus_SantaCasa/results .
#mv results user.otto.tavares.task.Manaus.manaus.cycle_v1_tb.r2.Manaus_to_SantaCasa.samples
#rm -rf fake_images_Manaus_SantaCasa
#