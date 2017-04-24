A=imread('Image_1.bmp');
subplot(3,1,1);
imshow(A);
title('Original image');
B=getnhood(strel('disk',11));
m=floor(size(B,1)/2);
n=floor(size(B,2)/2);
C=padarray(A,[m n],1);
D=false(size(A));
for i=1:size(C,1)-(2*m)
    for j=1:size(C,2)-(2*n) 
        Temp=C(i:i+(2*m),j:j+(2*n));
        D(i,j)=min(min(Temp-B));
    end
end
subplot(3,1,2);
imshow(~D);
title('Eroded Image');
B2=getnhood(strel('disk',11));
E=false(size(A));
for i=1:size(C,1)-(2*m)
    for j=1:size(C,2)-(2*n)
        Temp=C(i:i+(2*m),j:j+(2*n));
        E(i,j)=max(max(Temp&B2));
    end
end
subplot(3,1,3);
imshow(E);
title('Dilated Image');

