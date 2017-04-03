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
        zz=sqrt(Gx.^2+Gy.^2);
        if zz> 250
            B(i,j)=zz;
        else
            B(i,j)=0;
        end
      
    end
end
figure(),imshow(B); title('Sobel gradient');