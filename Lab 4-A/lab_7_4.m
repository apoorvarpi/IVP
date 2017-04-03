A = imread('image.jpg');
B=rgb2gray(A);

C=double(B);


for i=1:size(C,1)-2
    for j=1:size(C,2)-2
        %Sobel mask for x-direction:
        Gx=((2*C(i+2,j+1)+C(i+2,j)+C(i+2,j+2))-(2*C(i,j+1)+C(i,j)+C(i,j+2)));
        %Sobel mask for y-direction:
        Gy=((2*C(i+1,j+2)+C(i,j+2)+C(i+2,j+2))-(2*C(i+1,j)+C(i,j)+C(i+2,j)));
        %The gradient of the image
        B(i,j)=sqrt(Gx.^2+Gy.^2);
             
    end
end
subplot(221);
Q=B;
imshow(B); title('Sobel gradient');


for i=1:size(C,1)-2
    for j=1:size(C,2)-2
        %prewitt mask for x-direction:
        Gx=((1*C(i+2,j+1)+C(i+2,j)+C(i+2,j+2))-(1*C(i,j+1)+C(i,j)+C(i,j+2)));
        %prewitt mask for y-direction:
        Gy=((1*C(i+1,j+2)+C(i,j+2)+C(i+2,j+2))-(1*C(i+1,j)+C(i,j)+C(i+2,j)));
        %The gradient of the image
        B(i,j)=sqrt(Gx.^2+Gy.^2);
              
    end
end
subplot(222);
W=B;
imshow(B); title('prewit gradient');

E=Q-W;
subplot(223);
imshow(E); title('difference');

X=zeros(1,255);
for i=1:size(C,1)-2
    for j=1:size(C,2)-2
        pp=E(i,j)+1;
        X(1,pp)=  X(1,pp)+1;
    end
end
subplot(224);
stem(X);

%figure(); imhist(X); title('hist');
