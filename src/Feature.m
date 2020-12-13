% ����������ȡ
% ���룺����ͼƬ·��inputPath
% �������������FtCrude

function  FtCrude = Feature(inputPath)
% ���֡����洢����������

% ��64������48*48�ֳ�8*8�飬����ÿ������ص�ռ�ܺ����ص�ı���
FtCrude = zeros(1, 128);
count = 0; % ����������������
image1 = imread(inputPath);
image2 = imresize(image1, [48, 48]);

% ��48*48���طֳ�8*8�飬��64��������ÿ������ص�ռ�ܺ����ص�ı���
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

% �洢�����������ϵ��ڲ��ṹ����
% sum1[6]
% sum2[6]
count = 65;
% ˮƽ��������
for k = 1 : 8
    sum1 = zeros(1, 6);
    sum2 = zeros(1, 6);
    p1 = 0;
    p2 = 0;
    for i = 6 * k - 5 : 6 * k
        for j = 1 : 48
            % ��׼�ַ���߾�Ϊ48,���ַ���Ϊ8���,ͳ�������������׵����
            if image2(i, j) == 0 % 48*48����,����Ǻ����ص����1,
                sum1(i - 6 * (k - 1)) = sum1(i - 6 * (k - 1)) + 1;  
            else
                % ֱ����������ʻ�
                while j <= 48 && image2(i, j) == 1
                    j = j + 1;
                end
                % �������壬�ڶ����ֺ����ؿ�ĸ���
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
% ��ֱ�����ϵ���
for k = 1 : 8
    sum1 = zeros(1, 6);
    sum2 = zeros(1, 6);
    p1 = 0;
    p2 = 0;
    for j = 6 * k - 5 : 6 * k
        for i = 1 : 48
            % ��׼�ַ���߾�Ϊ48,���ַ���Ϊ8���,ͳ�������������׵����
            if image2(i, j) == 0 % 48*48����,����Ǻ����ص����1,
                sum1(j - 6 * (k - 1)) = sum1(j - 6 * (k - 1)) + 1;  
            else
                % ֱ����������ʻ�
                while i <= 48 && image2(i, j) == 1
                    i = i + 1;
                end
                % �������壬�ڶ����ֺ����ؿ�ĸ���
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
% ˮƽ�����ҵ���
for k = 1 : 8
    sum1 = zeros(1, 6);
    sum2 = zeros(1, 6);
    p1 = 0;
    p2 = 0;
    for i = 6 * k - 5 : 6 * k
        for j = 48 : -1 : 1
            % ��׼�ַ���߾�Ϊ48,���ַ���Ϊ8���,ͳ�������������׵����
            if image2(i, j) == 0 % 48*48����,����Ǻ����ص����1,
                sum1(i - 6 * (k - 1)) = sum1(i - 6 * (k - 1)) + 1;  
            else
                % ֱ����������ʻ�
                while j >= 1 && image2(i, j) == 1
                    j = j - 1;
                end
                % �������壬�ڶ����ֺ����ؿ�ĸ���
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
% ��ֱ�����µ���
for k = 1 : 8
    sum1 = zeros(1, 6);
    sum2 = zeros(1, 6);
    p1 = 0;
    p2 = 0;
    for j = 6 * k - 5 : 6 * k
        for i = 48 : -1 : 1
            % ��׼�ַ���߾�Ϊ48,���ַ���Ϊ8���,ͳ�������������׵����
            if image2(i, j) == 0 % 48*48����,����Ǻ����ص����1,
                sum1(j - 6 * (k - 1)) = sum1(j - 6 * (k - 1)) + 1;  
            else
                % ֱ����������ʻ�
                while i >= 1 && image2(i, j) == 1
                    i = i - 1;
                end
                % �������壬�ڶ����ֺ����ؿ�ĸ���
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
