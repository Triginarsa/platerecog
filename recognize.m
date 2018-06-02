function [ result, sample ] = recognize( deepnet )
%RECOGNIZE Summary of this function goes here
%   Detailed explanation goes here
imageWidth = 16;
imageHeight = 32;
inputSize = imageWidth*imageHeight;

sample_dir = 'datauji/';
Sample = imageDatastore(sample_dir,   'IncludeSubfolders', true, 'LabelSource', 'foldernames'); 
Banyaksample = numel(Sample.Files);
for i = 1:Banyaksample
    SamImg = readimage(Sample, i);
    SampleImg{i} = SamImg;
end

xTest = zeros(inputSize,numel(SampleImg));
for i = 1:numel(SampleImg)
    xTest(:,i) = SampleImg{i}(:);
end

y = deepnet(xTest);
hasil=round(y)
for i=1:numel(hasil(1,:))
    if hasil(1,i) == 1
        hasilakhir(:,i) = "0"
    elseif hasil(2,i) == 1
        hasilakhir(:,i) = "1"
    elseif hasil(3,i) == 1
        hasilakhir(:,i) = "2"
    elseif hasil(4,i) == 1
        hasilakhir(:,i) = "3"
    elseif hasil(5,i) == 1
        hasilakhir(:,i) = "4"
    elseif hasil(6,i) == 1
        hasilakhir(:,i) = "5"
    elseif hasil(7,i) == 1
        hasilakhir(:,i) = "6"
    elseif hasil(8,i) == 1
        hasilakhir(:,i) = "7"
    elseif hasil(9,i) == 1
        hasilakhir(:,i) = "8"
    elseif hasil(10,i) == 1
        hasilakhir(:,i) = "9"
    elseif hasil(11,i) == 1
        hasilakhir(:,i) = "A"
    elseif hasil(12,i) == 1
        hasilakhir(:,i) = "B"
    elseif hasil(13,i) == 1
        hasilakhir(:,i) = "C"
    elseif hasil(14,i) == 1
        hasilakhir(:,i) = "D"
    elseif hasil(15,i) == 1
        hasilakhir(:,i) = "E"
    elseif hasil(16,i) == 1
        hasilakhir(:,i) = "F"
    elseif hasil(17,i) == 1
        hasilakhir(:,i) = "G"
    elseif hasil(18,i) == 1
        hasilakhir(:,i) = "H"
    elseif hasil(19,i) == 1
        hasilakhir(:,i) = "I"
    elseif hasil(20,i) == 1
        hasilakhir(:,i) = "J"
    elseif hasil(21,i) == 1
        hasilakhir(:,i) = "K"
    elseif hasil(22,i) == 1
        hasilakhir(:,i) = "L"
    elseif hasil(23,i) == 1
        hasilakhir(:,i) = "M"
    elseif hasil(24,i) == 1
        hasilakhir(:,i) = "N"
    elseif hasil(25,i) == 1
        hasilakhir(:,i) = "O"
    elseif hasil(26,i) == 1
        hasilakhir(:,i) = "P"
    elseif hasil(27,i) == 1
        hasilakhir(:,i) = "Q"
    elseif hasil(28,i) == 1
        hasilakhir(:,i) = "R"
    elseif hasil(29,i) == 1
        hasilakhir(:,i) = "S"
    elseif hasil(30,i) == 1
        hasilakhir(:,i) = "T"
    elseif hasil(31,i) == 1
        hasilakhir(:,i) = "U"
    elseif hasil(32,i) == 1
        hasilakhir(:,i) = "V"
    elseif hasil(33,i) == 1
        hasilakhir(:,i) = "W"
    elseif hasil(34,i) == 1
        hasilakhir(:,i) = "X"
    elseif hasil(35,i) == 1
        hasilakhir(:,i) = "Y"
    elseif hasil(36,i) == 1
        hasilakhir(:,i) = "Z"
    end
end

A = rmmissing(hasilakhir);
C = cellstr(A);
Plat_kendaraan = sprintf('%s' ,C{:});

result = Plat_kendaraan;
sample = SampleImg;
end

