% 训练库图片切割,输入二值化的图像
function outputImage = CutImage(inputImage)

[M, N] = size(inputImage);
%垂直投影
vertical = zeros(1, N); %垂直投影
for i = 1 : N
    for j = 1 : M
        vertical(i) = vertical(i) + uint64(inputImage(j, i));
    end
end

colCount = 0;%记录汉字的列数
% colCoord; %汉字行数的上下坐标
flag = 1;
for i = 1 : M
    if(flag == 1 && vertical(i) > 0)%行上方的起始坐标
        colCount = colCount + 1;
        colCoord(colCount,1) = i; % - 0 为再汉字上方留空白
        flag = 0;
    end
end
for i = M : -1 : 1
    if(flag == 0 && vertical(i) > 0)%行上方的起始坐标
        colCoord(colCount,2) = i; % - 0 为再汉字上方留空白
        flag = 1;
    end
end

% 裁剪上方和下方无用区域
outputImage = inputImage(4 : M - 2, colCoord(1, 1) : colCoord(1, 2));

