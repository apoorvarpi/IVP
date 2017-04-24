A=imread('Image_1.bmp');
figure;
subplot(131);
imshow(A);
title('Original Image');
B=[1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1;1 1 1 1 1;1 1 1 1 1];%square
%B=[0 0 1 0 0; 0 1 1 1 0; 1 1 1 1 1;0 1 1 1 0;0 0 1 0 0];%circle
C=padarray(A,[1 1]);
D=false(size(A));
for i=1:size(C,1)-4
    for j=1:size(C,2)-4
        X = C(i:i+4, j:j+4);
        for k=1:5
            for l=1:5
                if B(k,l)==1 && X(k,l)==B(k,l)
                    D(i+2,j+2)=1;
                    break;
                end
            end
        end
    end
end
subplot(132);
imshow(D);
title('Dialated image');
subplot(133);
imshow(D-A);
title('Dialated-Original image');