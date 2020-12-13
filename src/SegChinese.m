%每一行的汉字切分
function [colCount2, colCoord2] = SegChinese(inputImage)
    [M, N] = size(inputImage);
    vertical = zeros(1, N); %垂直投影
    for i = 1 : N
        for j = 1 : M
            vertical(i) = vertical(i) + uint64(inputImage(j, i));
        end
    end
    
    colCount = 0;%记录一行中汉字个数
    % colCoord; %汉字行数的左右坐标
    flag = 1;
    for i = 1 : N - 2
        if(flag == 1 && vertical(i) > 0 && vertical(i + 1) > 0)%行上方的起始坐标
            colCount = colCount + 1;
            colCoord(colCount,1) = i;
            flag = 0;
        end
        if(flag == 0 && vertical(i) == 0 && vertical(i + 1) == 0 && vertical(i + 2) == 0)%行下方的起始坐标
            colCoord(colCount,2) = i;
            flag = 1;
        end
    end
    
    %汉字横向之间笔画可能间距过大，进行第一次调整
    width = 0;
    for i = 1:colCount
        width  = width + (colCoord(i,2) - colCoord(i,1));
    end
    width = width / colCount;
    colCount1 = 0;%记录一行中汉字个数
    % colCoord1; %汉字行数的左右坐标
    for i = 1 : N - 2
        if(flag == 1 && vertical(i) > 0 && vertical(i+1) > 0 && vertical(i+2) > 0)%行上方的起始坐标
            colCount1 = colCount1 + 1;
            colCoord1(colCount1, 1) = i;
            flag = 0;
        end
        if(flag == 0 && vertical(i) == 0 && ((i - colCoord1(colCount1,1)) > 0.9 * width) && vertical(i+1) == 0)%行下方的起始坐标
            colCoord1(colCount1, 2) = i;
            flag = 1;
        end
    end
    
    %将汉字宽度固定，进行第二次调整
    width = 0;
    for i = 1:colCount1
        width  = width + (colCoord1(i, 2) - colCoord1(i, 1));
    end
    width = width / colCount1;
    width = ceil(width);%向上取整

    colCount2 = 0;%记录一行中汉字个数
    %colCoord2; %汉字行数的左右坐标

    for i = 1 : N - 2
        if(flag == 1 && vertical(i) > 0 && vertical(i + 1) > 0 && vertical(i + 2) > 0) %行上方的起始坐标
            colCount2 = colCount2 + 1;
            colCoord2(colCount2, 1) = i; % 汉字左边空白uint16(width / 10)
            flag = 0;
        end
        if(flag == 0 && vertical(i) == 0 && ((i-colCoord2(colCount2, 1) > (width * 0.7))) && vertical(i+1) == 0)  %行下方的起始坐标
            colCoord2(colCount2, 2) = i - 1; % 汉字右边空白uint16(2 * width / 16) - uint16(width / 10)
            flag = 1;
        end
    end
end