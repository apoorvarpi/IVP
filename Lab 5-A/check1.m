I = imread('Image_4.bmp'); % Read Image
[rows,cols] = size(I);
f = fftshift(fft2(I));
wmax = max(f(:));
C = I;
[r c] = size(I);
for i = 1 : c
    for j =1 : r
        C(i,j) = (f(i,j) > .9*wmax) | (f(i,j) < .001*wmax);
    end;
end;
B = abs(ifft2(f.*C));
figure;
subplot(121);
imshow(I);
title('Original');
subplot(122);
imshow(B);
title('Filtered');