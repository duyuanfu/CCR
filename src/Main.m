% ����ʶ��ϵͳ
clear;
clc;
disp('����ʶ��ϵͳ');

% ����ͼ���ַ�����·����
inputPath = '../image/ori_img/example2.jpg';

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
        resultImage = Recognition(segPath1);
        
        subplot(rowCount, ceil(chineseCount / rowCount), i);
        imshow(resultImage);
end
% xlabel('ʶ��ͼ��');
