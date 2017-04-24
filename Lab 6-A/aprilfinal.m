g=imread('Image_1.bmp');
figure , imshow(g);
B=[1 1 1 1 1 1 1 1 1];
m=floor(size(B,1)/2);
n=floor(size(B,2)/2);
C=padarray(g,[m n],1);
x=padarray(g,[m n],0);
D=false(size(g));
y=false(size(g));
for i=1:size(C,1)-(2*m)
    for j=1:size(C,2)-(2*n)
       
        Temp=C(i:i+(2*m),j:j+(2*n));
        y(i,j)=max(max(bitand(Temp,B)));
        u=max(max(bitxor(Temp,B)));
        if(u==0)
            D(i,j)=1;
        end
    end
end
figure,imshow(D);
title('erosion');
figure,imshow(y);
title('dilation');