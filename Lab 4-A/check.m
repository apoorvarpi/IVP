A=imread('image.jpg');
B=rgb2gray(A);
B=imresize(B,[256,256]);
C=double(B);
H = fspecial('Gaussian',[5 5],0.7);
C = imfilter(C,H);
for i=1:size(C,1)-2
    for j=1:size(C,2)-2
        Gx=((2*C(i+2,j+1)+C(i+2,j)+C(i+2,j+2))-(2*C(i,j+1)+C(i,j)+C(i,j+2)));
        Gy=((2*C(i+1,j+2)+C(i,j+2)+C(i+2,j+2))-(2*C(i+1,j)+C(i,j)+C(i+2,j)));
        B(i,j)=sqrt(Gx.^2+Gy.^2);
      
    end
end
%imshow(B);
%title('Sobel');
Thresh=100;
B=max(B,Thresh);
B(B==round(Thresh))=0;
B=uint8(B);
figure,imshow(~B);title('Edge detected Image by sobel');
N(1:256,1:256)=0;
O(1:256,1:256)=0
for i=1:254;
    for j=1:254;
        N(i,j)=-1*C(i,j)-1*C(i,j+1)-1*C(i,j+2)+0+0+0+1*C(i+2,j)+1*C(i+2,j+1)+1*C(i+2,j+2);
        O(i,j)=1*C(i,j)+0-1*C(i,j+2)+1*C(i+2,j)+0-1*C(i+2,j+2)-1*C(i+2,j+1)+0+1*C(i,j+1);
    end;
end;
O=im2double(O);
N=im2double(N);
%N=imresize(N,[256,256]);
%O=imresize(O,[256,256]);
I2=N+O;
%figure,
%imshow(I2);
%title('Prewitt');
%title('Sobel');
I2=max(I2,Thresh);
I2(I2==round(Thresh))=0;
I2=uint8(I2);
figure,imshow(~I2);title('Edge detected Image by prewitt');
N(1:256,1:256)=0;
for i=1:254;
    for j=1:254;
        N(i,j)=-4*C(i+1,j+1)+C(i,j+1)+C(i+1,j)+C(i+2,j+1)+C(i+1,j+2);
    end;
end;
%figure,
%imshow(N);
I2=(~I2);
B=(~B);
S=I2-B;
figure,
imshow(S);
figure,
[M,N]=size(S);

t=1:256;
n=0:255;
count=0;
c2=0;
for z=1:256
    for i=1:M
        for j=1:N
            
            if S(i,j)==z-1
                count=count+1;
            end
        end
    end
            t(z)=count;
            count=0;
end
%disp(t')

stem(n,t); 
grid on;
ylabel('no. of pixels with such intensity levels---->');
xlabel('intensity levels---->'); title('HISTOGRAM OF THE IMAGE')
%figure,
%imhist((~B)-(~I2));