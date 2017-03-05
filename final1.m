clc;
close all;
clear all;

% % assigning the name of sample avi file to a variable
% filename = 'yy.mp4';
% 
% %reading a video file
% mov = VideoReader(filename);
% 
% % Defining Output folder as 'snaps'
% opFolder = fullfile( 'F:\video analysis','frames1');
% %if  not existing 
% if ~exist(opFolder, 'dir')
% %make directory & execute as indicated in opfolder variable
% mkdir(opFolder);
% end
% 
% %getting no of frames
% numFrames = mov.NumberOfFrames;
% division=ceil(numFrames/5);
% %setting current status of number of frames written to zero
% numFramesWritten = 0;
% 
% %for loop to traverse & process from frame '1' to 'last' frames 
% for t = 1 :division:numFrames
% currFrame = read(mov, t);    %reading individual frames
% opBaseFileName = sprintf('%3.3d.jpg', t);
% opFullFileName = fullfile(opFolder, opBaseFileName);
% imwrite(currFrame, opFullFileName, 'jpg');   %saving as 'png' file
% %indicating the current progress of the file/frame written
% progIndication = sprintf('Wrote frame %4d of %d.', t, numFrames);
% disp(progIndication);
% numFramesWritten = numFramesWritten + 1;
% end      %end of 'for' loop
% progIndication = sprintf('Wrote %d frames to folder "%s"',numFramesWritten, opFolder);
% disp(progIndication);

k=('019.jpg'); % input image; color image
im=imread(k);
im1=rgb2gray(im);
im2=medfilt2(im1,[3 3]); %Median filtering the image to remove noise%
BW = edge(im2,'sobel'); %finding edges 
[imx,imy]=size(BW);
msk=[0 0 0 0 0;
     0 1 1 1 0;
     0 1 1 1 0;
     0 1 1 1 0;
     0 0 0 0 0;];
B=conv2(double(BW),double(msk)); %Smoothing  image to reduce the number of connected components
L = bwlabel(B,8);% Calculating connected components
mx=max(max(L));
% There will be mx connected components.Here U can give a value between 1 and mx for L or in a loop you can extract all connected components
% If you are using the attached car image, by giving 17,18,19,22,27,28 to L you can extract the number plate completely. 
% Storing the extracted image in an array
 [rl cl]=size(L);
 n1=zeros(rl,cl);
for i1=1:mx
    [r ,c]=find(L==i1);
    rc=([r c]);
    [sx sy]=size(rc);
    for i2=1:sx
    x1=rc(i2,1);
    y1=rc(i2,2);
    n1(x1,y1)=255;
    end
    celll{i1}=n1;   % cell of all objects in L
    n1=zeros(rl,cl);
end


File=dir('H:\uni projects\logo extraction\logos\*.jpg'); %reading logos from folder
[r_f, c_f]=size(File);
[lm, lr]=size(L);
k=1;
k1=1;
 for iii=1:r_f
    img=imread(File(iii).name);
    img=imresize(img,[100, 140]);
    img=rgb2gray(img);
    [loc, lor]=size(img);
    lor1=lor;
 for ii=1:lm-loc
    for jj=1:lr-lor
y(k)=corr2(img,L(ii:loc,jj:lor));
k=k+1;
lor=lor+1;
     end
lor=lor1;
loc=loc+1;
 end
 y21(k1)=max(y);
 k1=k1+1;
 k=1;
 y=0;
end
 
figure,imshow(im);
figure,imshow(im1);
figure,imshow(B);
xx=find(y21==max(y21));
imshow(imread(File(xx).name));