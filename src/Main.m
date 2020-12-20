% 汉字识别系统
clear;
clc;
disp('Chinese Character Identification System');

% 输入图像地址（相对路径）
inputPath = '../image/ori_img/example1.jpg';

% 原图像
image1 = imread(inputPath);

% 二值化 
binPath = Binaryzation(inputPath);

% 消除噪音
eliPath = EliminatNoise(binPath);

% 汉字切分
[segPath, rowCount, chineseCount]= Segmentation(eliPath);

% 汉字识别
for i = 1 : chineseCount
        segPath1 = strcat(segPath, num2str(i), '.bmp');
        [resultImage, resultChar] = Recognition(segPath1);
        
        subplot(rowCount, ceil(chineseCount / rowCount), i);
        imshow(resultImage);
end
% xlabel('识别图像');
