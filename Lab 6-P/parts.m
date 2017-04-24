im=imread('pic.jpg');
im = rgb2gray(im);
figure,imshow(im)
%bwim1=adaptivethreshold(im,300,-0.15,0);
bw=bwareaopen(bwim1,3000);
se=strel('diamond',4);
er=imerode(bw,se);
bw1=bwareaopen(er,3000);
er1=imerode(bw1,se);
bw2=bwareaopen(er1,1000);
fi=imfill(bw2,'holes');
figure,imshow(fi)

op=uint8(fi);
seg=im.*op;
figure,imshow(seg)
imwrite(seg,'sliver7.jpg');