A=imread('Image_1.bmp');
figure;
subplot(131);
imshow(A);
title('Original Image');
B=[1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1];
C=padarray(A,[0 1],1);
D=false(size(A));
for i=1:size(C,1)-4
    for j=1:size(C,2)-4
        X=C(i:i+4,j:j+4);
        Y=find(B==1);
        X = C(i:i+4, j:j+4);
        flag = 1;
        for k=1:5
            for l=1:5
                if B(k,l)==1 && X(k,l)~=B(k,l)
                    flag = 0;
                end
            end
        end
        if(flag==1)
            D(i+2, j+2) = 1;
        end
    end
end
%display(D);
subplot(132);
imshow(D);
title('Eroded image');
subplot(133);
imshow(A-D);
title('Original-Eroded image');