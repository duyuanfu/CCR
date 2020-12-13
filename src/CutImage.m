% ѵ����ͼƬ�и�,�����ֵ����ͼ��
function outputImage = CutImage(inputImage)

[M, N] = size(inputImage);
%��ֱͶӰ
vertical = zeros(1, N); %��ֱͶӰ
for i = 1 : N
    for j = 1 : M
        vertical(i) = vertical(i) + uint64(inputImage(j, i));
    end
end

colCount = 0;%��¼���ֵ�����
% colCoord; %������������������
flag = 1;
for i = 1 : M
    if(flag == 1 && vertical(i) > 0)%���Ϸ�����ʼ����
        colCount = colCount + 1;
        colCoord(colCount,1) = i; % - 0 Ϊ�ٺ����Ϸ����հ�
        flag = 0;
    end
end
for i = M : -1 : 1
    if(flag == 0 && vertical(i) > 0)%���Ϸ�����ʼ����
        colCoord(colCount,2) = i; % - 0 Ϊ�ٺ����Ϸ����հ�
        flag = 1;
    end
end

% �ü��Ϸ����·���������
outputImage = inputImage(4 : M - 2, colCoord(1, 1) : colCoord(1, 2));

