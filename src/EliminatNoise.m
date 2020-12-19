% 采用八邻域法消除噪声，以达到降低噪声的目的
% 输入：输入图片路径inputPath
% 输出：输出图片路径outputPath
function outputPath = EliminatNoise(inputPath)

image1 = imread(inputPath);

% 检测到某一像素点为黑像素，找到该黑像素点的八邻域，看是否都为白像素，是则将检测到的黑像素点的灰度值置为白，
% 否则保持不变。
[M, N] = size(image1);
image2 = ones(M, N);
for i = 2 : M - 1
    for j = 2 : N - 1
        if(image1(i, j) == 0 && image1(i - 1, j - 1) ~= 0 && image1(i - 1, j) ~= 0 && image1(i - 1, j + 1) ~= 0 && image1(i, j - 1) ~= 0 && image1(i, j + 1) ~= 0 && image1(i + 1, j - 1) ~= 0 && image1(i + 1, j) ~= 0 && image1(i + 1, j + 1) ~= 0)
            image2(i, j) = 1;
        else
            image2(i, j) = image1(i, j);
        end
    end
end
image3 = logical(image2);

folder='../image/eli_img/';
if ~exist(folder,'dir')
	mkdir(folder)
end
outputPath = [folder, '1.bmp'];
imwrite(image3, outputPath);
