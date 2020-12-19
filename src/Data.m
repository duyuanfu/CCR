% 训练汉字库，获得汉字库中每一个字的特征向量
clc;
clear;

chineseNum = 2822; % 汉字数量
for i = 1 : chineseNum
    str = num2str(i);
    readPath = strcat('../image/lib_img/',str,'.bmp');
    image1 = imread(readPath);
    image2 = imbinarize(image1);
    image3 = CutImage(image2);
    
    folder='../image/cut_img/';
    if ~exist(folder,'dir')
        mkdir(folder)
    end
    writePath = [folder, str, '.bmp'];
    imwrite(image3, writePath);
    InitChineseCrude(i, :) = Feature(writePath);
end
