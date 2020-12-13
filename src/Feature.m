% 汉字特征提取
% 输入：输入图片路径inputPath
% 输出：特征向量FtCrude

function  FtCrude = Feature(inputPath)
% 汉字——存储粗网格特征

% 共64个，将48*48分成8*8块，计算每块黑像素点占总黑像素点的比例
FtCrude = zeros(1, 128);
count = 0; % 用来当作索引变量
image1 = imread(inputPath);
image2 = imresize(image1, [48, 48]);

% 将48*48像素分成8*8块，共64个，计算每块黑像素点占总黑像素点的比例
for i = 1 : 8
    for j = 1 : 8
        count = count + 1;
        sum = 0;
        for  m = 6 * i - 5 : 6 * i
            for n = 6 * j - 5 + 1 : 6 * j
                if image2(m, n) == 1
                    sum = sum + 1;
                end
            end
        end
        FtCrude(count) = sum / 36.00;
    end
end

% 存储横条和竖条上的内部结构特征
% sum1[6]
% sum2[6]
count = 65;
% 水平：从左到右
for k = 1 : 8
    sum1 = zeros(1, 6);
    sum2 = zeros(1, 6);
    p1 = 0;
    p2 = 0;
    for i = 6 * k - 5 : 6 * k
        for j = 1 : 48
            % 标准字符宽高均为48,将字符分为8横块,统计整个字里左侧白点个数
            if image2(i, j) == 0 % 48*48特征,如果是黑像素点则加1,
                sum1(i - 6 * (k - 1)) = sum1(i - 6 * (k - 1)) + 1;  
            else
                % 直接跳过字体笔画
                while j <= 48 && image2(i, j) == 1
                    j = j + 1;
                end
                % 穿过字体，第二部分黑像素块的个数
                while j <= 48 && image2(i, j) == 0
                   j = j + 1;
                   sum2(i - 6 * (k - 1)) = sum2(i - 6 * (k - 1)) + 1;
                end
                break;            
            end
        end 
    end
    for i = 1 : 6
        p1 = p1 + sum1(i);
        p2 = p2 + sum2(i);
    end
    FtCrude(count) = p1/double(48 * 48);
    count = count + 1;
    FtCrude(count) = p2/double(48 * 48);
    count = count + 1;
end
% 竖直：从上到下
for k = 1 : 8
    sum1 = zeros(1, 6);
    sum2 = zeros(1, 6);
    p1 = 0;
    p2 = 0;
    for j = 6 * k - 5 : 6 * k
        for i = 1 : 48
            % 标准字符宽高均为48,将字符分为8横块,统计整个字里左侧白点个数
            if image2(i, j) == 0 % 48*48特征,如果是黑像素点则加1,
                sum1(j - 6 * (k - 1)) = sum1(j - 6 * (k - 1)) + 1;  
            else
                % 直接跳过字体笔画
                while i <= 48 && image2(i, j) == 1
                    i = i + 1;
                end
                % 穿过字体，第二部分黑像素块的个数
                while i <= 48 && image2(i, j) == 0
                   i = i + 1;
                   sum2(j - 6 * (k - 1)) = sum2(j - 6 * (k - 1)) + 1;
                end
                break;            
            end
        end 
    end
    for i = 1 : 6
        p1 = p1 + sum1(i);
        p2 = p2 + sum2(i);
    end
    FtCrude(count) = p1/double(48 * 48);
    count = count + 1;
    FtCrude(count) = p2/double(48 * 48);
    count = count + 1;
end
% 水平：从右到左
for k = 1 : 8
    sum1 = zeros(1, 6);
    sum2 = zeros(1, 6);
    p1 = 0;
    p2 = 0;
    for i = 6 * k - 5 : 6 * k
        for j = 48 : -1 : 1
            % 标准字符宽高均为48,将字符分为8横块,统计整个字里左侧白点个数
            if image2(i, j) == 0 % 48*48特征,如果是黑像素点则加1,
                sum1(i - 6 * (k - 1)) = sum1(i - 6 * (k - 1)) + 1;  
            else
                % 直接跳过字体笔画
                while j >= 1 && image2(i, j) == 1
                    j = j - 1;
                end
                % 穿过字体，第二部分黑像素块的个数
                while j >= 1 && image2(i, j) == 0
                   j = j - 1;
                   sum2(i - 6 * (k - 1)) = sum2(i - 6 * (k - 1)) + 1;
                end
                break;       
            end
        end 
    end
    for i = 1 : 6
        p1 = p1 + sum1(i);
        p2 = p2 + sum2(i);
    end
    FtCrude(count) = p1/double(48 * 48);
    count = count + 1;
    FtCrude(count) = p2/double(48 * 48);
    count = count + 1;
end
% 竖直：从下到上
for k = 1 : 8
    sum1 = zeros(1, 6);
    sum2 = zeros(1, 6);
    p1 = 0;
    p2 = 0;
    for j = 6 * k - 5 : 6 * k
        for i = 48 : -1 : 1
            % 标准字符宽高均为48,将字符分为8横块,统计整个字里左侧白点个数
            if image2(i, j) == 0 % 48*48特征,如果是黑像素点则加1,
                sum1(j - 6 * (k - 1)) = sum1(j - 6 * (k - 1)) + 1;  
            else
                % 直接跳过字体笔画
                while i >= 1 && image2(i, j) == 1
                    i = i - 1;
                end
                % 穿过字体，第二部分黑像素块的个数
                while i >= 1 && image2(i, j) == 0
                   i = i - 1;
                   sum2(j - 6 * (k - 1)) = sum2(j - 6 * (k - 1)) + 1;
                end
                break;            
            end
        end 
    end
    for i = 1 : 6
        p1 = p1 + sum1(i);
        p2 = p2 + sum2(i);
    end
    FtCrude(count) = p1/double(48 * 48);
    count = count + 1;
    FtCrude(count) = p2/double(48 * 48);
    count = count + 1;
end
