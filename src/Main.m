% ����ʶ��ϵͳ
clear;
clc;
disp('Chinese Character Identification System');

% ����ͼ���ַ�����·����
inputPath = '../image/ori_img/example1.jpg';

% ԭͼ��
image1 = imread(inputPath);

% ��ֵ�� 
binPath = Binaryzation(inputPath);

% ��������
eliPath = EliminatNoise(binPath);

% �����з�
[segPath, rowCount, chineseCount]= Segmentation(eliPath);

% ����ʶ��
for i = 1 : chineseCount
        segPath1 = strcat(segPath, num2str(i), '.bmp');
        [resultImage, resultChar] = Recognition(segPath1);
        
        subplot(rowCount, ceil(chineseCount / rowCount), i);
        imshow(resultImage);
end
% xlabel('ʶ��ͼ��');
