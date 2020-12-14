% 字体细化

clc;
clear;

image = imread( '../image/bin_img/example1.bmp');
subplot(121);
imshow(image);

[M, N] = size(image);

flag = true;
while(flag)
    flag = false;
    for i = 3 : M - 2
        for j = 3 : N - 2   
            condition1 = false;
            condition2 = false;
            condition3 = false;
            condition4 = false;
            if image(i, j) == 1
                continue;
            end
            % 获得当前点相邻的5X5区域内像素值，白色用0表示，黑色用1表示
            neighbour = zeros(5, 5);
            for m = -2 : 2
                for n = -2 : 2
                    if image(i + m, j + n) == 1
                        neighbour(m + 3, n + 3) = 0;
                    else
                        neighbour(m + 3, n + 3) = 1;
                    end
                end
            end        
            % 条件1 目标像素8邻域的黑像素点
            L = neighbour(2, 2) + neighbour(2, 3) + neighbour(2, 4) + neighbour(3, 2) + neighbour(3, 4) + neighbour(4, 2) + neighbour(4, 3) + neighbour(4, 4);
            if 2 <= L && L <= 6
                condition1 = true;
            end
            % 条件2 序列的0 -> 1 的变化次数
            T = getT(neighbour, 3, 3);
            if T == 1
                condition2 = true;
            end
            % 条件3
            if neighbour(2, 3) * neighbour(3, 2) * neighbour(3, 4) == 0
                condition3 = true;
            else
                T = getT(neighbour, 2, 3);
                if T == 1
                    condition3 = true;
                end
            end
            % 条件4
            if neighbour(2, 3) * neighbour(3, 2) * neighbour(4, 3) == 0
                condition4 = true;
            else
                T = getT(neighbour, 3, 2);
                if T == 1
                    condition4 = true;
                end
            end
            if condition1 && condition2 && condition3 && condition4
                image(i ,j) = 1;
                flag = true;
            else
                image(i ,j) = 0;
            end
            
        end
    end
end

subplot(122);
imshow(image);


function T = getT(neighbour, m, n)
    % 序列的0 -> 1 的变化次数
    T = 0;  
    if neighbour(m - 1, n) == 0 && neighbour(m - 1, n - 1) == 1
        T = T + 1;
    end
    if neighbour(m - 1, n - 1) == 0 && neighbour(m, n - 1) == 1
        T = T + 1;
    end
    if neighbour(m, n - 1) == 0 && neighbour(m + 1, n - 1) == 1
        T = T + 1;
    end
    if neighbour(m + 1, n - 1) == 0 && neighbour(m + 1, n) == 1
        T = T + 1;
    end
    if neighbour(m + 1, n) == 0 && neighbour(m + 1, n + 1) == 1
        T = T + 1;
    end
    if neighbour(m + 1, n + 1) == 0 && neighbour(m, n + 1) == 1
        T = T + 1;
    end
    if neighbour(m, n + 1) == 0 && neighbour(m - 1, n + 1) == 1
        T = T + 1;
    end
    if neighbour(m - 1, n + 1) == 0 && neighbour(m - 1, n) == 1
        T = T + 1;
    end
end