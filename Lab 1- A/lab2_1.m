RGB = imread('Image.jpg');
I = rgb2gray(RGB);
I = im2double(I);
[m n] = size(I);
c = 1.0;
g = [0.5 3];
figure;
subplot(1,3,1); imshow(I);
for r=1:length(g)
    for p = 1 : m
        for q = 1 : n
            I3(p, q) = c * I(p, q).^ g(r);  
        end
    end
    subplot(1,3,r+1);
    imshow(I3);
end