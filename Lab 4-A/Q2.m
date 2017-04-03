A=imread('image.jpg');
B=rgb2gray(A);
D=rgb2gray(A);
C=double(B);
for i=1:size(C,1)-2
    for j=1:size(C,2)-2
        Gx=((2*C(i+2,j+1)+C(i+2,j)+C(i+2,j+2))-(2*C(i,j+1)+C(i,j)+C(i,j+2)));
        Gx1=((C(i+2,j+1)+C(i+2,j)+C(i+2,j+2))-(C(i,j+1)+C(i,j)+C(i,j+2)));
        Gy=((2*C(i+1,j+2)+C(i,j+2)+C(i+2,j+2))-(2*C(i+1,j)+C(i,j)+C(i+2,j)));
        Gy1=((C(i+1,j+2)+C(i,j+2)+C(i+2,j+2))-(C(i+1,j)+C(i,j)+C(i+2,j)));
        B(i+1,j+1)=sqrt(Gx.^2+Gy.^2);
        D(i+1,j+1)=sqrt(Gx1.^2+Gy1.^2);
    end
end
E = (255+B-D)/2;
X=zeros(1,255);
for i=1:size(C,1)-2
    for j=1:size(C,2)-2
        pp=E(i,j)+1;
        X(1,pp)=  X(1,pp)+1;
    end
end
figure;
subplot(221);
imshow(B);
title('Sobel');
subplot(222)
imshow(D);
title('Prewitt');
subplot(223);
imshow(E);
title('Difference');
subplot(224);
stem(X);
grid on;
xlim([0 255]);
xlabel('Intensity');
ylabel('Number of pixels');
title('Histogram');
