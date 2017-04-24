im=imread('Image_4.bmp');
ft=fftshift(log(abs(fft2(im))));
figure; subplot(121); imshow(ft,[]); axis on;
[co,ro] = size(im);
cx = round(co/2); % find the center of the image
cy = round (ro/2);
n=1;
fc=10; %cutoff frequency
%imf=fftshift(fft2(im));
H=zeros(co,ro);
for i = 1 : co
    for j =1 : ro
        d = (i-cx).^2 + (j-cy).^ 2;
        H(i,j) = 1/(1+((d/fc/fc).^(2*n)));
    end;
end;
outf = ft .* H;
out = uint8(abs(ifft2(outf)));
subplot(122); imshow(out);