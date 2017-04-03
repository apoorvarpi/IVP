I = imread('Face.jpg');
I = rgb2gray(I);
[L, a] = bwlabeln(I,4);
[L, b] = bwlabeln(I,8);
disp('Number of 4 connected components:');
disp(a);
disp('Number of 8 connected components:');
disp(a);
