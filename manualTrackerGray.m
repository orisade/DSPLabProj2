%%Signal Processing Laboratory - Project 2 - task 9
%Ori Sade - 318262128
%Liav Cohen - 209454693
clc;
close all;
%opening video for reading
videoFileReader = vision.VideoFileReader(which('rhinos.avi'));

%reading a single image from video - for start
videoFrame = double(rgb2gray(step(videoFileReader)));
figure; imshow(videoFrame);
selcetedBox = drawrectangle();
BBox = selcetedBox.Position;
%initialize histogram
x = int16(BBox(1));
y = int16(BBox(2));
w = int16(BBox(3));
h = int16(BBox(4));
ROICenter = [x+w/2 y+h/2];

%initialize histogram
hist = zeros(256,1);
for row = x:x+w-1
   for col = y:y+h-1
       value = int8(videoFrame(row,col)*256);
       hist(value+ 1) = hist(value+ 1) + 1;
   end
end
figure; plot(hist); title('manual hist');
hist2 = imhist(videoFrame(x:x+w-1, y:y+h-1));
figure; plot(hist2); title('auto hist');

%% Searching algorithem
pddist(hist,hist2);


%%

%BBox = BBox + 10;
%videoOut = insertObjectAnnotation(videoFrame,'rectangle',BBox,'box');
%drawrectangle('Position',BBox);


