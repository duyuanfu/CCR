% ���ð����������������Դﵽ����������Ŀ��
% ���룺����ͼƬ·��inputPath
% ��������ͼƬ·��outputPath
function outputPath = EliminatNoise(inputPath)

image1 = imread(inputPath);

% ��⵽ĳһ���ص�Ϊ�����أ��ҵ��ú����ص�İ����򣬿��Ƿ�Ϊ�����أ����򽫼�⵽�ĺ����ص�ĻҶ�ֵ��Ϊ�ף�
% ���򱣳ֲ��䡣
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
