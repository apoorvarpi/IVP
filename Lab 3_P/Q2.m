I = imread('Earth.jpg');
figure;
subplot(121)
imshow(I);
title('Original')
subplot(122)
imshow(J);
title('Original*0.25');
H = fspecial('laplacian');
F = imfilter(I,H);
M = I + F;
%L = 0.5*I + 0.5*F;
L = I;
maxa = max(L(:))
mina = min(L(:))
[rows,cols,z]= size(L);
for i = 1:rows
    for j =1:cols
        if L(i,j)>=mina
            L(i,j) = ((L(i,j)-mina));
        end
        L(i,j) = L(i,j)/maxa;
    end
end
J = L;
H = fspecial('laplacian');
F = imfilter(J,H);
L = 0.5*I + 0.5*F;
figure;
subplot(234);
imshow(J);
title('Original');
subplot(235);
imshow(F);
title('Mask');
subplot(236);
imshow(L);
title('Final');
F = imfilter(J,H);
L = 0.5*J + 0.5*F;
N = J + F;
%L = N;
%maxa = max(L(:))
%mina = min(L(:))
%[rows,cols,z]= size(L);
%for i = 1:rows
%    for j =1:cols
%        if L(i,j)>=mina
%            L(i,j) = ((L(i,j)-mina)/maxa);
%        end
%        L(i,j) = L(i,j)/maxa;
%    end
%end
subplot(231);
imshow(I);
title('Original*0.25');
subplot(232);
imshow(F);
title('Mask');
subplot(233);
imshow(L);
title('Final');
figure;
subplot(121)
imshow(N);
title('Unnormalised with scaling');
subplot(122)
imshow(M);
title('Unnormalised without scaling');


