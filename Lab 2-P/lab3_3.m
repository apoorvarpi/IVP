I = imread('Face.jpg');
figure;
subplot(2,2,1);
imshow(I);
title('Face');

EyeDetect = vision.CascadeObjectDetector('EyePairBig');
BB=step(EyeDetect,I);
Eyes=imcrop(I,BB);
subplot(2,2,2);
imshow(Eyes);
title('Eyes');

NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',16);
BB=step(NoseDetect,I);
Nose=imcrop(I,BB);
subplot(2,2,3);
imshow(Nose);
title('Nose');

MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',40);
BB=step(MouthDetect,I);
Lips=imcrop(I,BB);
subplot(2,2,4);
imshow(Lips);
title('Lips');