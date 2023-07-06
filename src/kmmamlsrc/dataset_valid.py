import pathlib
import random
import numpy as np
import h5py
from torch.utils.data import Dataset
import torch
from skimage import feature
import os 
from utils import npComplexToTorch

class SliceDataDev(Dataset):
    """
    A PyTorch Dataset that provides access to MR image slices.
    """
    def __init__(self, root,acc_factor,dataset_type,mask_type,mask_path):
        self.datasetdict = {'mrbrain_t1_few':0,'mrbrain_flair':1,'mrbrain_ir':2,'ixi_pd':3,'ixi_t2':4, 'zenodo_t1':0, 'zenodo_t2':4, 'sri24t1':0,'sri24pd':3,'sri24t2':4,'zenodo_trial_t1':0}
        self.maskdict={'cartesian':0,'gaussian':1}
  
        # List the h5 files in root 
        files = list(pathlib.Path(root).iterdir())
        self.examples = []
        self.mask_path = mask_path
        for fname in sorted(files):
            with h5py.File(fname,'r') as hf:
                fsvol = hf['volfs']
                num_slices = fsvol.shape[2]
                #acc_factor = float(acc_factor[:-1].replace("_","."))
                self.examples += [(fname, slice, acc_factor,mask_type,dataset_type) for slice in range(num_slices)]



    def __len__(self):
        return len(self.examples)

    def __getitem__(self, i):
        # Index the fname and slice using the list created in __init__
        
        fname, slice, acc_factor,mask_type,dataset_type = self.examples[i]
    
        with h5py.File(fname, 'r') as data:

            key_img = 'img_volus_{}'.format(acc_factor)
            key_kspace = 'kspace_volus_{}'.format(acc_factor)
            input_img  = data[key_img][:,:,slice]
            input_kspace  = data[key_kspace][:,:,slice]
            input_kspace = npComplexToTorch(input_kspace)
            target = data['volfs'][:,:,slice]

            acc_val = float(acc_factor[:-1].replace("_","."))
            mask_val = self.maskdict[mask_type]
            dataset_val = self.datasetdict[dataset_type]

            mask = np.load(os.path.join(self.mask_path,dataset_type,mask_type,'mask_{}.npy'.format(acc_factor)))

            gamma_input = np.array([acc_val, mask_val,dataset_val])
            return torch.from_numpy(input_img), input_kspace, torch.from_numpy(target),str(fname.name),slice, torch.from_numpy(gamma_input), acc_factor, mask_type, dataset_type,torch.from_numpy(mask)

