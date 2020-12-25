% 训练汉字库，获得汉字库中每一个字的特征向量
% 输入：输入训练图片路径inputPath
% 输出：无
chineseNum = 3018; % 汉字数量
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

% % 保存特征向量到指定文件夹
% feaPath='../data/';
% if ~exist(feaPath, 'dir')
%     mkdir(feaPath);
% end
% % save([feaPath, 'features.mat'], 'InitChineseCrude');
% 
% imwrite(InitChineseCrude,[feaPath, 'features.bmp']);
