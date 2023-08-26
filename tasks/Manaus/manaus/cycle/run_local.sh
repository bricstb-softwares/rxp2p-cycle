python /home/joao.pinto/git_repos/brics/rxp2p-cycle/train.py \
--dataroot /home/brics/public/brics_data/Manaus/manaus/raw \
--custom_images_path /home/brics/public/brics_data/Manaus/manaus/raw/images \
--dataset_download_dir /home/joao.pinto/git_repos/brics/rxp2p-cycle/tasks/Manaus/manaus/cycle \
--download_imgs \
--model cycle_gan \
--dataset_mode unalignedskfoldmanaus \
--token b16fe0fc92088c4840a98160f3848839e68b1148 \
--name check_job.test_3.sort_3 \
--preprocess resize_and_scale_width \
--use_wandb \
--wandb_fold_id check_job.test_3.sort_3 \
--no_flip  \
--wandb_entity brics-tb  \
--gpu_ids 0 \
--n_epochs 100 \
--n_epochs_decay 100 \
--load_size 256 \
--crop_size 256 \
--isTB \
--job job.test_3.sort_3.json \
--project job.test_3.sort_3