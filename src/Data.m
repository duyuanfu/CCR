% ѵ�����ֿ⣬��ú��ֿ���ÿһ���ֵ���������
clc;
clear;

chineseNum = 2822; % ��������
for i = 1 : chineseNum
    str = num2str(i);
    readPath = strcat('../image/lib_img/',str,'.bmp');
    image1 = imread(readPath);
    image2 = imbinarize(image1);
    image3 = CutImage(image2);
    writePath = strcat('../image/cut_img/',str,'.bmp');
    imwrite(image3, writePath);
    InitChineseCrude(i, :) = Feature(writePath);
end
