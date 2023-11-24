import os

## separate the dataset into train and test sets
import os
import random

def separate_train_test(dataset_path, train_path, test_path, train_ratio):
    ## open the dataset file 
    dataset_file = open(dataset_path, 'r')

    ## read the lines of the dataset file and shuffle them randomly
    lines = dataset_file.readlines()

    ## get the header & remove it from the lines
    header = lines[0]
    lines = lines[1:]

    ## shuffle the lines
    random.shuffle(lines)

    ## get the number of data in the file
    num_data = len(lines)
    num_train = int(num_data * train_ratio)

    ## open the train and test files
    with open(train_path, 'w') as train_file, open(test_path, 'w') as test_file:
        ## write the header to the train and test files
        train_file.write(header)
        test_file.write(header)
        
        ## write the data to the train and test files randomly
        for i, line in enumerate(lines):
            if i < num_train:
                train_file.write(line)
            else:
                test_file.write(line)

## run the function
dataset_path = "dataset/fake_accounts.csv"
train_path = "dataset/fake_accounts_train.csv"
test_path = "dataset/fake_accounts_test.csv"

separate_train_test(dataset_path, train_path, test_path, 0.8)
