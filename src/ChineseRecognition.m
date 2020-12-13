% 找到字库里匹配的字号
% 输入：输入图片路径inputinputPath
% 输出：识别图像结果resultImage
function resultImage = ChineseRecognition(inputPath)
chineseNum = 2822;
load('../data/matlab.mat');

L_index = ones(1, 20);% 汉字近邻候选值
L_e = ones(1, 20);
Lm_index = ones(1, 10);
Lm_e = ones(1, 10);
Lp_index = ones(1, 10);
Lp_e = ones(1, 10);

eLm0_e = ones(1, chineseNum);
eLm0_index = ones(1, chineseNum);
eLp0_e = ones(1, chineseNum);
eLp0_index = ones(1, chineseNum);

FtCrude = Feature(inputPath);
% InitChineseCrude = zeros(chineseNum, 128);


% 得到652对（eLm0()，eLp0()）的值，eLm0[]值为待识别字的粗网格特征和字库中每一个字的粗网格特征的距离的平方的累计值
for i = 1 : chineseNum
   for j = 1 : 64
       eLm0_e(i) = eLm0_e(i) + (FtCrude(j) - InitChineseCrude(i, j)) * (FtCrude(j) - InitChineseCrude(i, j));
       eLm0_index(i) = i;
   end
   for j = 65 : 128
       eLp0_e(i) = eLp0_e(i) + (FtCrude(j) - InitChineseCrude(i, j)) * (FtCrude(j) - InitChineseCrude(i, j));
       eLp0_index(i) = i;  
   end
end
% 选取与字库里粗外围特征距离最小的10个
for i =1 : 10
    Lp_e(i) = eLp0_e(1);
    for j = 1 : chineseNum 
        if eLp0_e(j) <= Lp_e(i)
            Lp_e(i) = eLp0_e(j);
            Lp_index(i) = eLp0_index(j);     
        end
    end
    eLp0_e(Lp_index(i)) = 100;
end


% 选取与字库里粗网格特征距离最小的10个
for i = 1 : 10
    Lm_e(i) = eLm0_e(1);
    for j = 1 : chineseNum 
        if eLm0_e(j) <= Lm_e(i)
            Lm_e(i) = eLm0_e(j);
            Lm_index(i) = eLm0_index(j);     
        end
    end
    eLm0_e(Lm_index(i)) = 100;
end
% 合并差异度，相似的前10个字库字符构成另外的特征数组L[]
count = 1;
for i = 1 : 10
    flag= 0;
    for j = 1 : 10
        % 排序的10个字符中，两种特征都入围的合并特征作为特征，做标记
        if Lm_index(i) == Lp_index(j)
            L_e(count) = Lm_e(i) + 0.4 * Lp_e(j);% 参数可变
            Lp_index(j) = 1;
            L_index(count) = Lm_index(i);
            flag = 1;
            break;
        end
    end
    if flag == 0 % 如果只有Lm特征，那么就取Lp[4]与其合并作为特征
        L_e(count) = Lm_e(i) + 0.4 * Lp_e(4);
        L_index(count) = Lm_index(i);
    end
    count = count + 1;  
end
for i = 1 : 10
    if Lp_index(i) == 1 % 如果Lp值已使用
        continue;
    else % 如果Lp值未使用，则将其和Lm[4]合并作为特征
        L_e(count) = 0.4 + Lp_e(i) + Lm_e(4);
        L_index(count) = Lp_index(i);
        count = count + 1;  
    end       
end
% 对所有特征由小到大排序（包括所有Lp和Lm中出现的字库）
for i = 1 : count
    for j = 2 : count - i - 1
        if L_e(j) < L_e(j - 1)
            tempE = L_e(j);
            tempIndex = L_index(j);
            L_e(j) = L_e(j - 1);
            L_index(j) = L_index(j - 1);
            L_e(j - 1) = tempE;
            L_index(j - 1) = tempIndex;
        end
    end
end
resultIndex = L_index(1);  % 找到最小值,记录最相似的汉字所在的位置
resultDist = L_e(1); % 记录最相似的汉字的相似度


str = num2str(resultIndex);
location = strcat('../image/lib_img/',str,'.bmp');
resultImage = imread(location);
   