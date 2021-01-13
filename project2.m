clear;
clc;
close all;
%opening video for reading
videoFileReader = vision.VideoFileReader(which('Fox.wmv'));

%reading a single image from video - for start
videoFrame = step(videoFileReader);
figure; imshow(videoFrame);
selcetedBox = drawrectangle();
%getting user BBox
bbox = selcetedBox.Position;
%Create a tracker object.
Nbins=8;
rgbHist = colorHist(videoFrame,Nbins);
tracker = vision.HistogramBasedTracker;
initializeObject(tracker, rgbHist, int16(bbox(1,:)),Nbins^3);
%[hueChannel,satChannel,valChannel] = rgb2hsv(videoFrame);
%tracker = vision.HistogramBasedTracker;
%initializeObject(tracker, hueChannel, int16(bbox(1,:)));

%opening a video object for playing the video
videoInfo = info(videoFileReader); % information about the source video
videoPlayer = vision.VideoPlayer('Position',[300 300 videoInfo.VideoSize]);

%creating an object for writing a video to it
v = VideoWriter('output.avi');
open(v);
videoOut = insertObjectAnnotation(videoFrame,'rectangle',bbox,'Face');
%writing first frame to video
writeVideo(v,videoOut);

%the process of tracking the selected image 
while ~isDone(videoFileReader) %untill video is finished
 % Extract the next video frame
 videoFrame = step(videoFileReader);
 
 
 % RGB -> HSV	%WE DON'T NEED IT
 rgbHist = colorHist(videoFrame,Nbins); % discard saturation and value channels
 % Track the face using the Hue channel data	%NEED THE RGB
 bbox = step(tracker, rgbHist);
 %[hueChannel,~,~] = rgb2hsv(videoFrame); % discard saturation and value channel
 %bbox = step(tracker, hueChannel);

 % Insert a bounding box around the object being tracked
 videoOut = insertObjectAnnotation(videoFrame,'rectangle',bbox,'object');
 % Display the annotated video frame using the video player object
 step(videoPlayer, videoOut);
 % Write frame to output video
 writeVideo(v,videoOut);
end

% Release resources
release(videoFileReader);
release(videoPlayer);
% Close output video
close(v);


%%regarding the manual run we can see full example in lab7. define it as function and test it

function newI=colorHist(I,Nbins)
        maxPixel = Nbins*Nbins^0+Nbins*Nbins^1+Nbins*Nbins^2;
        newI = zeros(size(I,1),size(I,2));
        for x=1:size(I,1)
            for y=1:size(I,2)
                R = int16(I(x,y,1)*Nbins); G = int16(I(x,y,2)*Nbins); B = int16(I(x,y,3)*Nbins);
                newI(x,y) = R+G*Nbins+B*Nbins^2;
                newI(x,y) = newI(x,y)/maxPixel;
            end
        end
end




