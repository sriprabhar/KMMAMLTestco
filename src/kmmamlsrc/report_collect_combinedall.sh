MODEL='km_mamlcotest' 
BASE_PATH='../MRI'
echo ${MODEL}

for DATASET_TYPE in 'mrbrain_t1_few' 
    do
    for MASK_TYPE in 'cartesian' 
        do 
        for ACC_FACTOR in '4x' '5x' 
            do 
            echo ${DATASET_TYPE}','${MASK_TYPE}','${ACC_FACTOR} 
            REPORT_PATH=${BASE_PATH}'/experiments/maml/'${MODEL}'/report_'${DATASET_TYPE}'_'${MASK_TYPE}'_'${ACC_FACTOR}'.txt'
            echo ${REPORT_PATH}
            cat ${REPORT_PATH}
            echo "\n"
            done 
        done 
    done 

