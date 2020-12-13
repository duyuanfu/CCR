%ÿһ�еĺ����з�
function [colCount2, colCoord2] = SegChinese(inputImage)
    [M, N] = size(inputImage);
    vertical = zeros(1, N); %��ֱͶӰ
    for i = 1 : N
        for j = 1 : M
            vertical(i) = vertical(i) + uint64(inputImage(j, i));
        end
    end
    
    colCount = 0;%��¼һ���к��ָ���
    % colCoord; %������������������
    flag = 1;
    for i = 1 : N - 2
        if(flag == 1 && vertical(i) > 0 && vertical(i + 1) > 0)%���Ϸ�����ʼ����
            colCount = colCount + 1;
            colCoord(colCount,1) = i;
            flag = 0;
        end
        if(flag == 0 && vertical(i) == 0 && vertical(i + 1) == 0 && vertical(i + 2) == 0)%���·�����ʼ����
            colCoord(colCount,2) = i;
            flag = 1;
        end
    end
    
    %���ֺ���֮��ʻ����ܼ����󣬽��е�һ�ε���
    width = 0;
    for i = 1:colCount
        width  = width + (colCoord(i,2) - colCoord(i,1));
    end
    width = width / colCount;
    colCount1 = 0;%��¼һ���к��ָ���
    % colCoord1; %������������������
    for i = 1 : N - 2
        if(flag == 1 && vertical(i) > 0 && vertical(i+1) > 0 && vertical(i+2) > 0)%���Ϸ�����ʼ����
            colCount1 = colCount1 + 1;
            colCoord1(colCount1, 1) = i;
            flag = 0;
        end
        if(flag == 0 && vertical(i) == 0 && ((i - colCoord1(colCount1,1)) > 0.9 * width) && vertical(i+1) == 0)%���·�����ʼ����
            colCoord1(colCount1, 2) = i;
            flag = 1;
        end
    end
    
    %�����ֿ�ȹ̶������еڶ��ε���
    width = 0;
    for i = 1:colCount1
        width  = width + (colCoord1(i, 2) - colCoord1(i, 1));
    end
    width = width / colCount1;
    width = ceil(width);%����ȡ��

    colCount2 = 0;%��¼һ���к��ָ���
    %colCoord2; %������������������

    for i = 1 : N - 2
        if(flag == 1 && vertical(i) > 0 && vertical(i + 1) > 0 && vertical(i + 2) > 0) %���Ϸ�����ʼ����
            colCount2 = colCount2 + 1;
            colCoord2(colCount2, 1) = i; % ������߿հ�uint16(width / 10)
            flag = 0;
        end
        if(flag == 0 && vertical(i) == 0 && ((i-colCoord2(colCount2, 1) > (width * 0.7))) && vertical(i+1) == 0)  %���·�����ʼ����
            colCoord2(colCount2, 2) = i - 1; % �����ұ߿հ�uint16(2 * width / 16) - uint16(width / 10)
            flag = 1;
        end
    end
end