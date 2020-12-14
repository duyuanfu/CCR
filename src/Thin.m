% ����ϸ��

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
            % ��õ�ǰ�����ڵ�5X5����������ֵ����ɫ��0��ʾ����ɫ��1��ʾ
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
            % ����1 Ŀ������8����ĺ����ص�
            L = neighbour(2, 2) + neighbour(2, 3) + neighbour(2, 4) + neighbour(3, 2) + neighbour(3, 4) + neighbour(4, 2) + neighbour(4, 3) + neighbour(4, 4);
            if 2 <= L && L <= 6
                condition1 = true;
            end
            % ����2 ���е�0 -> 1 �ı仯����
            T = getT(neighbour, 3, 3);
            if T == 1
                condition2 = true;
            end
            % ����3
            if neighbour(2, 3) * neighbour(3, 2) * neighbour(3, 4) == 0
                condition3 = true;
            else
                T = getT(neighbour, 2, 3);
                if T == 1
                    condition3 = true;
                end
            end
            % ����4
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
    % ���е�0 -> 1 �ı仯����
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