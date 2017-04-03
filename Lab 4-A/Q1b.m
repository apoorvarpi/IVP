A=imread('image.jpg');
B=rgb2gray(A);
th = input('Enter threshold: ');
C=double(B);
for i=1:size(C,1)-2
    for j=1:size(C,2)-2
        Gx=((C(i+2,j+1)+C(i+2,j)+C(i+2,j+2))-(C(i,j+1)+C(i,j)+C(i,j+2)));
        Gy=((C(i+1,j+2)+C(i,j+2)+C(i+2,j+2))-(C(i+1,j)+C(i,j)+C(i+2,j)));
        var=sqrt(Gx.^2+Gy.^2);
        if var>th
            B(i+1,j+1) = 255;
        else
            B(i+1,j+1) = 0;
        end
    end
end
figure;
subplot(121)
imshow(rgb2gray(A));
title('Original');
subplot(122);
imshow(B);
title('Prewitt gradient');
