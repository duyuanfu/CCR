% �ҵ��ֿ���ƥ����ֺ�
% ���룺����ͼƬ·��inputinputPath
% �����ʶ��ͼ����resultImage
function resultImage = ChineseRecognition(inputPath)
chineseNum = 2822;
load('../data/matlab.mat');

L_index = ones(1, 20);% ���ֽ��ں�ѡֵ
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


% �õ�652�ԣ�eLm0()��eLp0()����ֵ��eLm0[]ֵΪ��ʶ���ֵĴ������������ֿ���ÿһ���ֵĴ����������ľ����ƽ�����ۼ�ֵ
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
% ѡȡ���ֿ������Χ����������С��10��
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


% ѡȡ���ֿ������������������С��10��
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
% �ϲ�����ȣ����Ƶ�ǰ10���ֿ��ַ������������������L[]
count = 1;
for i = 1 : 10
    flag= 0;
    for j = 1 : 10
        % �����10���ַ��У�������������Χ�ĺϲ�������Ϊ�����������
        if Lm_index(i) == Lp_index(j)
            L_e(count) = Lm_e(i) + 0.4 * Lp_e(j);% �����ɱ�
            Lp_index(j) = 1;
            L_index(count) = Lm_index(i);
            flag = 1;
            break;
        end
    end
    if flag == 0 % ���ֻ��Lm��������ô��ȡLp[4]����ϲ���Ϊ����
        L_e(count) = Lm_e(i) + 0.4 * Lp_e(4);
        L_index(count) = Lm_index(i);
    end
    count = count + 1;  
end
for i = 1 : 10
    if Lp_index(i) == 1 % ���Lpֵ��ʹ��
        continue;
    else % ���Lpֵδʹ�ã������Lm[4]�ϲ���Ϊ����
        L_e(count) = 0.4 + Lp_e(i) + Lm_e(4);
        L_index(count) = Lp_index(i);
        count = count + 1;  
    end       
end
% ������������С�������򣨰�������Lp��Lm�г��ֵ��ֿ⣩
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
resultIndex = L_index(1);  % �ҵ���Сֵ,��¼�����Ƶĺ������ڵ�λ��
resultDist = L_e(1); % ��¼�����Ƶĺ��ֵ����ƶ�


str = num2str(resultIndex);
location = strcat('../image/lib_img/',str,'.bmp');
resultImage = imread(location);
   