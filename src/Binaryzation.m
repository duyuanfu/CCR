% 二次定值法进行二值化
% 输入：输入图片路径inputPath
% 输出：输出图片路径outputPath
function outputPath = Binaryzation(inputPath)

% 读取原图像
image1 = imread(inputPath); 

% 灰度化
image2 = rgb2gray(image1);

% 求取平均灰度值averGrayValue，获得阈值T1
[M, N] = size(image2); % 求取图像尺寸,M-行，N-列
minGrayValue = min(min(image2)); % 求最小灰度均值
expValue = 220; % 经验值
T1 = minGrayValue + expValue;

% 通过阈值T1，求取低于或高于平均灰度值的两组平均灰度值
lowGrayValue = 0; % 低于平均灰度值的像素灰度值总和
highGrayValue = 0;
lowGrayCount = 0; % 低于平均灰度值的像素个数
highGrayCount = 0;
averLowGrayValue = 0; % 低于平均灰度值的像素的平均灰度值
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

%重新定义阈值T2,根据二次阈值T2对图像做二值化处理。
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