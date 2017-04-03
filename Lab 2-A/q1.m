function [window, wmax, wmin] = new_image(fig1, fig2)
fig1 = imread('books.jpg');
fig2 = imread('bird.jpg');
w1 = 0.5 * fig1;
w2 = 0.5 * fig2;
window = w1+w2;
wmax = max(window(:));
wmin = min(window(:));
disp('Max value:');
disp(wmax);
disp('Min value:');
disp(wmin);
x=input('press enter key:');
figure;
subplot(131)
imshow(fig1);
title('figure 1');
subplot(132)
imshow(fig2);
title('figure 2');
subplot(133);
imshow(window);
title('figure 1 + figure 2');