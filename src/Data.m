% ѵ�����ֿ⣬��ú��ֿ���ÿһ���ֵ���������
% ���룺����ѵ��ͼƬ·��inputPath
% �������
chineseNum = 3018; % ��������
for i = 1 : chineseNum
    str = num2str(i);
    readPath = strcat('../image/lib_img/',str,'.bmp');
    image1 = imread(readPath);
    image2 = imbinarize(image1);
    image3 = CutImage(image2);
    
    folder='../image/cut_img/';
    if ~exist(folder,'dir')
        mkdir(folder);
    end
    writePath = [folder, str, '.bmp'];
    imwrite(image3, writePath);
    InitChineseCrude(i, :) = Feature(writePath);
end

% % ��������������ָ���ļ���
% feaPath='../data/';
% if ~exist(feaPath, 'dir')
%     mkdir(feaPath);
% end
% % save([feaPath, 'features.mat'], 'InitChineseCrude');
% 
% imwrite(InitChineseCrude,[feaPath, 'features.bmp']);
