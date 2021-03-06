A=imread('Image_1.bmp');
figure;
subplot(131);
imshow(A);
%B=[1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1;1 1 1 1 1;1 1 1 1 1];%square
B=[0 0 1 0 0; 0 1 1 1 0; 1 1 1 1 1;0 1 1 1 0;0 0 1 0 0];%circle
C=padarray(A,[0 1],1);
D=false(size(A));
for i=1:size(C,1)-4
    for j=1:size(C,2)-4
        X=C(i:i+4,j:j+4);
        Y=find(B==1);
        if(X(Y)==1)
            D(i+2,j+2)=1;
        end
    end
end
subplot(132);
imshow(D);
subplot(133);
imshow(A-D);