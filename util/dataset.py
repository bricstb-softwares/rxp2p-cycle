
__all__ = ['DownloadDataset']

from util.stratified_kfold import stratified_train_val_test_splits_bins
from colorama import init, Back, Fore
from PIL import Image as Img
from PIL import ImageOps
from tqdm import tqdm
import pandas as pd
init(autoreset=True)
import pickle
import requests
import json
import os




class Client:

    def __init__(self, token):
        self.__header = { "Authorization": 'Token '+token}

    def dataset(self, name):
        response = requests.get('https://dorothy-image.lps.ufrj.br/images/?search={DATASET}'.format(DATASET=name), 
                                headers=self.__header)
        data = json.loads(response.content)
        return Dataset(data, self.__header)
    


class Dataset:

    def __init__(self, data, header ):
        self.__header = header
        self.__images = [Image(d, self.__header) for d in data]

    def list_images(self):
        return self.__images

class Image:

    def __init__(self, raw, header):
        self.__header = header
        self.dataset_name = raw['dataset_name']
        self.project_id = raw['project_id']
        self.image_url = raw['image_url']
        self.metadata = raw['metadata']
        self.date_acquisition = raw['date_acquisition']
        self.insertion_date = raw['insertion_date']

    def download( self, output):
        file = open(output,"wb")
        response = requests.get(self.image_url, headers=self.__header)
        file.write(response.content)
        file.close()

        # fix image 
        img = Img.open(output)
        if not 'china' in output:
            img = ImageOps.exif_transpose(img)
        img.save(output)


        


#
# Decorate with targets
#


def china_label(metadata):
    return metadata['has_tb']
def imageamento_label(metadata):
    return False
def imageamento_anonimizado_valid_label(metadata):
    return False
def manaus_label(metadata):
    return metadata['has_tb']




datasets = {
                'china'                         : china_label,
                'manaus'                        : manaus_label,
                'imageamento'                   : imageamento_label,
                'imageamento_anonimizado_valid' : imageamento_anonimizado_valid_label,

}



#
# Dataset
#

class DownloadDataset:

    """Download specified dataset from Dorothy"""


    def __init__(self,token, tests = 10, seed = 512):
        self.service = Client(token=token)
        self.seed = seed
        self.tests = tests

        

    def download(self, dataset_name, folder, basepath=os.getcwd()):

        if not dataset_name in datasets.keys():
            raise(f'Dataset ({dataset_name}) not supported.')

        output_images = basepath + '/' + folder + '/images'
        # Creating output dir    
        os.makedirs(output_images, exist_ok=True)
        dataset = self.service.dataset(dataset_name)

        # template
        d = {
            'dataset_name'     : [],
            'project_id'       : [],
            #'target'          : [],
            #'image_md5'       : [],
            #'image_url'       : [],
            'image_path'       : [],
            'insertion_date'   : [],
            'metadata'         : [],
            #'date_acquisition': [],
            #'number_reports'  : [],
            'target'           : [],
        }

        # Download each image
        for image in tqdm(dataset.list_images()):
            d['dataset_name'].append(image.dataset_name)
            d['project_id'].append(image.project_id)
            image_path = output_images+'/%s'%(image.project_id)+'.png' 
            if not os.path.exists(image_path):
                image.download(image_path)
            d['image_path'].append(image_path)
            d['metadata'].append(image.metadata)
            d['insertion_date'].append(image.insertion_date)
            d['target'].append(datasets[dataset_name](image.metadata))
            
        df = pd.DataFrame(d)
        df = df.sort_values('project_id')
        df.to_csv(basepath+'/'+folder+'/images.csv')

        with open(basepath+'/'+folder+'/'+'splits.pic','wb') as f:
            splits = stratified_train_val_test_splits_bins(df,self.tests,self.seed)
            pickle.dump(splits,f)


        return df






if __name__ == "__main__":
    token = "b16fe0fc92088c4840a98160f3848839e68b1148"
    c = DownloadDataset(token)
    df = c.download('china', 'dataset')

