% ��ͼ��������зֺ����з�
% ���룺����ͼƬ·��inputPath
% ��������ͼƬ����һ��·��outputPath, �ָ�����rowCount�� �������colCount
function [outputPath, rowCount, chineseCount] = Segmentation(inputPath)

image1 = imread(inputPath);

chineseCount = 0; % ���ڼ���ͼƬ�еĺ�������
% ��ͼ������ֵȡ��
[M, N] = size(image1);
image2 = zeros(M, N);
for i = 1 : M
    for j = 1 : N
        if(image1(i, j) == true)
            image2(i, j) = 0;
        else 
            image2(i, j) = 1;
        end
    end
end

% ���з�
horizontal = zeros(1, M); % ˮƽͶӰ, vertical
for i = 1 : M
    for j = 1 : N
        horizontal(i) = horizontal(i) + image2(i, j);
    end
end

rowCount = 0;%��¼���ֵ�����
% rowCoord; %������������������
flag = 1;
for i = 1 : M
    if(flag == 1 && horizontal(i) > 0)%���Ϸ�����ʼ����
        rowCount = rowCount + 1;
        rowCoord(rowCount,1) = i; % -0 Ϊ�ٺ����Ϸ����հ�
        flag = 0;
    end
    if(flag == 0 && horizontal(i) == 0) % ���·�����ʼ����
        rowCoord(rowCount, 2) = i - 1; % + 4 Ϊ�ٺ����Ϸ����հ�
        flag = 1;
    end
end

folder='../image/seg_img/';
if ~exist(folder,'dir')
	mkdir(folder)
end
outputPath = folder;
for i = 1 : rowCount
    [colCount, colCoord] = SegChinese(image2(rowCoord(i, 1) : rowCoord(i, 2), :));
    for j = 1 : colCount
        image3 = image2(rowCoord(i, 1):rowCoord(i, 2),colCoord(j, 1):colCoord(j,2));
        image4 = logical(image3);
        chineseCount = chineseCount + 1;
        imwrite(image4, [outputPath, num2str(chineseCount, '%d'), '.bmp']);
    end
end