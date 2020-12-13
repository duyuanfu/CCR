% ���ζ�ֵ�����ж�ֵ��
% ���룺����ͼƬ·��inputPath
% ��������ͼƬ·��outputPath
function outputPath = Binaryzation(inputPath)

% ��ȡԭͼ��
image1 = imread(inputPath); 

% �ҶȻ�
image2 = rgb2gray(image1);

% ��ȡƽ���Ҷ�ֵaverGrayValue�������ֵT1
[M, N] = size(image2); % ��ȡͼ��ߴ�,M-�У�N-��
minGrayValue = min(min(image2)); % ����С�ҶȾ�ֵ
expValue = 220; % ����ֵ
T1 = minGrayValue + expValue;

% ͨ����ֵT1����ȡ���ڻ����ƽ���Ҷ�ֵ������ƽ���Ҷ�ֵ
lowGrayValue = 0; % ����ƽ���Ҷ�ֵ�����ػҶ�ֵ�ܺ�
highGrayValue = 0;
lowGrayCount = 0; % ����ƽ���Ҷ�ֵ�����ظ���
highGrayCount = 0;
averLowGrayValue = 0; % ����ƽ���Ҷ�ֵ�����ص�ƽ���Ҷ�ֵ
averHighGrayValue = 0;
for i = 1 : M
    for j = 1 : N
        if image2(i, j) > T1
            highGrayValue = highGrayValue + uint64(image2(i, j)); 
            highGrayCount = highGrayCount + 1;
        else 
            lowGrayValue = lowGrayValue + uint64(image2(i, j));
            lowGrayCount = lowGrayCount + 1;
        end
    end
end
averLowGrayValue = lowGrayValue / lowGrayCount;
averHighGrayValue = highGrayValue / highGrayCount;

%���¶�����ֵT2,���ݶ�����ֵT2��ͼ������ֵ������
T2 = (averLowGrayValue + averHighGrayValue) / 2;
image3 = zeros(M,N);
for i = 1 : M
    for j = 1 : N
        if image2(i, j) > T2 
            image3(i, j) = 1;
        else
            image3(i, j) = 0;
        end
    end
end
image4 = logical(image3);
outputPath = '../image/bin_img/example1.bmp';
imwrite(image4, outputPath);