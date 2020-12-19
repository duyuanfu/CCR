% 对图像进行行切分和字切分
% 输入：输入图片路径inputPath
% 输出：输出图片的上一层路径outputPath, 分割行数rowCount， 风格列数colCount
function [outputPath, rowCount, chineseCount] = Segmentation(inputPath)

image1 = imread(inputPath);

chineseCount = 0; % 用于计数图片中的汉字数量
% 对图像像素值取反
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

% 行切分
horizontal = zeros(1, M); % 水平投影, vertical
for i = 1 : M
    for j = 1 : N
        horizontal(i) = horizontal(i) + image2(i, j);
    end
end

rowCount = 0;%记录汉字的行数
% rowCoord; %汉字行数的上下坐标
flag = 1;
for i = 1 : M
    if(flag == 1 && horizontal(i) > 0)%行上方的起始坐标
        rowCount = rowCount + 1;
        rowCoord(rowCount,1) = i; % -0 为再汉字上方留空白
        flag = 0;
    end
    if(flag == 0 && horizontal(i) == 0) % 行下方的起始坐标
        rowCoord(rowCount, 2) = i - 1; % + 4 为再汉字上方留空白
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