function [ deepnet ] = train()
%TRAIN Summary of this function goes here
%   Detailed explanation goes here
dataset_dir = 'dataset/';

dataset = imageDatastore(dataset_dir,   'IncludeSubfolders', true, 'LabelSource', 'foldernames');
BanyakChar = countEachLabel(dataset);
BanyakImg = numel(dataset.Files);

CharImg = string(dataset.Labels);
Char = zeros(numel(double(table2array(BanyakChar(:,1)))),BanyakImg);

for i = 1:BanyakImg
    dataImg = readimage(dataset, i);
    DatasetImg{i} = dataImg;
    if CharImg(i)== "0"
        Char(1,i) = 1;
    elseif CharImg(i) == "1"
        Char(2,i) = 1;
    elseif CharImg(i) == "2"
        Char(3,i) = 1;
    elseif CharImg(i) == "3"
        Char(4,i) = 1;
    elseif CharImg(i) == "4"
        Char(5,i) = 1;
    elseif CharImg(i) == "5"
        Char(6,i) = 1;
    elseif CharImg(i) == "6"
        Char(7,i) = 1;
    elseif CharImg(i) == "7"
        Char(8,i) = 1;
    elseif CharImg(i) == "8"
        Char(9,i) = 1;
    elseif CharImg(i) == "9"
        Char(10,i) = 1;
    elseif CharImg(i) == "A"
        Char(11,i) = 1;
    elseif CharImg(i) == "B"
        Char(12,i) = 1;
    elseif CharImg(i) == "C"
        Char(13,i) = 1;
    elseif CharImg(i) == "D"
        Char(14,i) = 1;
    elseif CharImg(i) == "E"
        Char(15,i) = 1;
    elseif CharImg(i) == "F"
        Char(16,i) = 1;
    elseif CharImg(i) == "G"
        Char(17,i) = 1;
    elseif CharImg(i) == "H"
        Char(18,i) = 1;
    elseif CharImg(i) == "I"
        Char(19,i) = 1;
    elseif CharImg(i) == "J"
        Char(20,i) = 1;
    elseif CharImg(i) == "K"
        Char(21,i) = 1;
    elseif CharImg(i) == "L"
        Char(22,i) = 1;
    elseif CharImg(i) == "M"
        Char(23,i) = 1;
    elseif CharImg(i) == "N"
        Char(24,i) = 1;
    elseif CharImg(i) == "O"
        Char(25,i) = 1;
    elseif CharImg(i) == "P"
        Char(26,i) = 1;
    elseif CharImg(i) == "Q"
        Char(27,i) = 1;
    elseif CharImg(i) == "R"
        Char(28,i) = 1;
    elseif CharImg(i) == "S"
        Char(29,i) = 1;
    elseif CharImg(i) == "T"
        Char(30,i) = 1;
    elseif CharImg(i) == "U"
        Char(31,i) = 1;
    elseif CharImg(i) == "V"
        Char(32,i) = 1;
    elseif CharImg(i) == "W"
        Char(33,i) = 1;
    elseif CharImg(i) == "X"
        Char(34,i) = 1;
    elseif CharImg(i) == "Y"
        Char(35,i) = 1;
    elseif CharImg(i) == "Z"
        Char(36,i) = 1;
    end
    %c = dec2bin(a(i), 8);
    %Limg(:,i) = c(:) - '0';
end

rng('default')

hiddenSize1 = 100;

autoenc1 = trainAutoencoder(DatasetImg,hiddenSize1, ...
    'MaxEpochs',400, ...
    'L2WeightRegularization',0.004, ...
    'SparsityRegularization',4, ...
    'SparsityProportion',0.15, ...
    'ScaleData', false);

feat1 = encode(autoenc1,DatasetImg);

hiddenSize2 = 50;
autoenc2 = trainAutoencoder(feat1,hiddenSize2, ...
    'MaxEpochs',100, ...
    'L2WeightRegularization',0.002, ...
    'SparsityRegularization',4, ...
    'SparsityProportion',0.1, ...
    'ScaleData', false);

feat2 = encode(autoenc2,feat1);

softnet = trainSoftmaxLayer(feat2,Char,'MaxEpochs',400);


deepnet = stack(autoenc1,autoenc2,softnet);

% Get the number of pixels in each image
imageWidth = 16;
imageHeight = 32;
inputSize = imageWidth*imageHeight;

% Turn the training images into vectors and put them in a matrix
xTrain = zeros(inputSize,numel(DatasetImg));
for i = 1:numel(DatasetImg)
    xTrain(:,i) = DatasetImg{i}(:);
end

% Perform fine tuning
deepnet = train(deepnet,xTrain,Char);
end

