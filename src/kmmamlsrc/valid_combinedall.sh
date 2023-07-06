MODEL='km_mamlcotest' 
BASE_PATH='../MRI'
CHECKPOINT=${BASE_PATH}'/experiments/maml/'${MODEL}'/best_model_save.pt'
BATCH_SIZE=1
DEVICE='cuda:0'
USMASK_PATH=${BASE_PATH}'/usmasks/'
RESULT_FOLDER='results_valid'

mkdir ${BASE_PATH}'/experiments/maml/'${MODEL}'/'${RESULT_FOLDER}

DISENTANGLE_MODEL_PATH='../MRI/ae_model/best_model.pt'
for DATASET_TYPE in 'mrbrain_t1_few'
    do
    mkdir ${BASE_PATH}'/experiments/maml/'${MODEL}'/'${RESULT_FOLDER}'/'${DATASET_TYPE}	
    for MASK_TYPE in 'cartesian' 
        do 
        mkdir ${BASE_PATH}'/experiments/maml/'${MODEL}'/'${RESULT_FOLDER}'/'${DATASET_TYPE}'/'${MASK_TYPE}	
        for ACC_FACTOR in '4x' '5x' 
            do 
            echo ${DATASET_TYPE}','${MASK_TYPE}','${ACC_FACTOR}
            mkdir ${BASE_PATH}'/experiments/maml/'${MODEL}'/'${RESULT_FOLDER}'/'${DATASET_TYPE}'/'${MASK_TYPE}'/acc_'${ACC_FACTOR}	
            OUT_DIR=${BASE_PATH}'/experiments/maml/'${MODEL}'/'${RESULT_FOLDER}'/'${DATASET_TYPE}'/'${MASK_TYPE}'/acc_'${ACC_FACTOR}
            DATA_PATH=${BASE_PATH}'/datasets/'${DATASET_TYPE}'/'${MASK_TYPE}'/valid_query/acc_'${ACC_FACTOR}
            echo python valid.py --checkpoint ${CHECKPOINT} --out-dir ${OUT_DIR} --batch-size ${BATCH_SIZE} --device ${DEVICE} --data-path ${DATA_PATH} --acceleration_factor ${ACC_FACTOR} --dataset_type ${DATASET_TYPE} --mask_type ${MASK_TYPE} --usmask_path ${USMASK_PATH} --disentangle-model-path ${DISENTANGLE_MODEL_PATH}
            python valid.py --checkpoint ${CHECKPOINT} --out-dir ${OUT_DIR} --batch-size ${BATCH_SIZE} --device ${DEVICE} --data-path ${DATA_PATH} --acceleration_factor ${ACC_FACTOR} --dataset_type ${DATASET_TYPE} --mask_type ${MASK_TYPE} --usmask_path ${USMASK_PATH} --disentangle-model-path ${DISENTANGLE_MODEL_PATH}
            done 
        done 
    done




