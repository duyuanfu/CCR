% 汉字识别系统
clear;
clc;
disp('汉字识别系统');

% 输入图像地址（相对路径）
inputPath = '../image/ori_img/example1.jpg';

% 原图像
image1 = imread(inputPath);

% 二值化
binPath = Binaryzation(inputPath);

% 消除噪音
eliPath = EliminatNoise(binPath);

% 汉字切分
[segPath, rowCount, colCount]= Segmentation(eliPath);

% 汉字识别
for i = 1 : rowCount
    for j = 1 : colCount
        segPath1 = strcat(segPath, num2str((i - 1) * colCount + j), '.bmp');
        resultImage = ChineseRecognition(segPath1);
        subplot(rowCount, colCount, (i - 1) * colCount + j);
        imshow(resultImage);
    end
end
xlabel('识别图像');
