% ����ʶ��ϵͳ
clear;
clc;
disp('����ʶ��ϵͳ');

% ����ͼ���ַ�����·����
inputPath = '../image/ori_img/example1.jpg';

% ԭͼ��
image1 = imread(inputPath);

% ��ֵ��
binPath = Binaryzation(inputPath);

% ��������
eliPath = EliminatNoise(binPath);

% �����з�
[segPath, rowCount, colCount]= Segmentation(eliPath);

% ����ʶ��
for i = 1 : rowCount
    for j = 1 : colCount
        segPath1 = strcat(segPath, num2str((i - 1) * colCount + j), '.bmp');
        resultImage = ChineseRecognition(segPath1);
        subplot(rowCount, colCount, (i - 1) * colCount + j);
        imshow(resultImage);
    end
end
xlabel('ʶ��ͼ��');
