MODEL='km_mamlcotest' 
BASE_PATH='../MRI'

for DATASET_TYPE in 'mrbrain_t1_few'
    do
    for MASK_TYPE in 'cartesian'
        do 
        for ACC_FACTOR in '4x' 
            do 
            echo ${DATASET_TYPE}','${MASK_TYPE}','${ACC_FACTOR} 
            TARGET_PATH=${BASE_PATH}'/datasets/'${DATASET_TYPE}'/'${MASK_TYPE}'/valid_query/acc_'${ACC_FACTOR}
            PREDICTIONS_PATH=${BASE_PATH}'/experiments/maml/'${MODEL}'/results_valid/'${DATASET_TYPE}'/'${MASK_TYPE}'/acc_'${ACC_FACTOR}'/'
            REPORT_PATH=${BASE_PATH}'/experiments/maml/'${MODEL}'/'
            python evaluate_slicewise.py --target-path ${TARGET_PATH} --predictions-path ${PREDICTIONS_PATH} --report-path ${REPORT_PATH} --acc-factor ${ACC_FACTOR} --mask-type ${MASK_TYPE} --dataset-type ${DATASET_TYPE}
            done 
        done 
    done

