MODEL='km_mamlcotest' 
BASE_PATH='../MRI'

DATASET_TYPE='mrbrain_t1_few' 
MASK_TYPE='cartesian' 
ACC_FACTORS='4x','5x' 

TRAIN_TASK_STRINGS='mrbrain_t1_few_cartesian_4x','mrbrain_t1_few_cartesian_5x'


TRAIN_SUPPORT_BATCH_SIZE=10
VAL_SUPPORT_BATCH_SIZE=10

TRAIN_QUERY_BATCH_SIZE=10
VAL_QUERY_BATCH_SIZE=10

TRAIN_TASK_BATCH_SIZE=3
VAL_TASK_BATCH_SIZE=6

TRAIN_NUM_ADAPTATION_STEPS=1
VAL_NUM_ADAPTATION_STEPS=1

NUM_EPOCHS=100
DEVICE='cuda:0'


EXP_DIR=${BASE_PATH}'/experiments/maml/'${MODEL}
TRAIN_PATH=${BASE_PATH}

#VALIDATION_PATH=${BASE_PATH}'/datasets/'

USMASK_PATH=${BASE_PATH}
DISENTANGLE_MODEL_PATH='../MRI/ae_model/best_model.pt'

echo python train.py --train_task_batch_size ${TRAIN_TASK_BATCH_SIZE} --val_task_batch_size ${VAL_TASK_BATCH_SIZE} --task_strings ${TRAIN_TASK_STRINGS} --num-epochs ${NUM_EPOCHS} --device ${DEVICE} --exp-dir ${EXP_DIR} --train_path ${TRAIN_PATH} --dataset_type ${DATASET_TYPE} --usmask_path ${USMASK_PATH} --acceleration_factor ${ACC_FACTORS} --mask_type ${MASK_TYPE} --train_support_batch_size ${TRAIN_SUPPORT_BATCH_SIZE} --train_query_batch_size ${TRAIN_QUERY_BATCH_SIZE} --val_support_batch_size ${VAL_SUPPORT_BATCH_SIZE} --val_query_batch_size ${VAL_QUERY_BATCH_SIZE} --no_of_train_adaptation_steps ${TRAIN_NUM_ADAPTATION_STEPS} --no_of_val_adaptation_steps ${VAL_NUM_ADAPTATION_STEPS}

python train.py --train_task_batch_size ${TRAIN_TASK_BATCH_SIZE} --val_task_batch_size ${VAL_TASK_BATCH_SIZE} --task_strings ${TRAIN_TASK_STRINGS} --num-epochs ${NUM_EPOCHS} --device ${DEVICE} --exp-dir ${EXP_DIR} --train_path ${TRAIN_PATH} --dataset_type ${DATASET_TYPE} --usmask_path ${USMASK_PATH} --acceleration_factor ${ACC_FACTORS} --mask_type ${MASK_TYPE} --train_support_batch_size ${TRAIN_SUPPORT_BATCH_SIZE} --train_query_batch_size ${TRAIN_QUERY_BATCH_SIZE} --val_support_batch_size ${VAL_SUPPORT_BATCH_SIZE} --val_query_batch_size ${VAL_QUERY_BATCH_SIZE} --no_of_train_adaptation_steps ${TRAIN_NUM_ADAPTATION_STEPS} --no_of_val_adaptation_steps ${VAL_NUM_ADAPTATION_STEPS} --disentangle-model-path ${DISENTANGLE_MODEL_PATH}
