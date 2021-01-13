%%Signal Processing Laboratory - Project 2 - task 9
%Ori Sade - 318262128
%Liav Cohen - 209454693
clc;
clear;
close all;
%% user inputs
filename = 'Fox.wmv';
outFilename = 'output.avi';
Nbins=16;   %for RGB this value is equal to Nbins^3 {RGB matrix}.
RGB = false;

%% Initialization - reading first Image and select object
%reading a single image from video
videoFileReader = vision.VideoFileReader(which(filename));
if RGB
    videoFrame = double(step(videoFileReader));
    videoFrameFit = convertRGB(videoFrame,Nbins);    
    lastVideoFrame = videoFrameFit;
else
    videoFrame = double(rgb2gray(step(videoFileReader)));
    lastVideoFrame = videoFrame;
end
figure; imshow(videoFrame);
selcetedBox = drawrectangle();
BBox = selcetedBox.Position;
close;
%opening a video object for playing the video
videoInfo = info(videoFileReader); % information about the source video
videoPlayer = vision.VideoPlayer('Position',[300 300 videoInfo.VideoSize+30]);
%BAR INFO
numberOfFrames = videoInfo.VideoFrameRate*mmfileinfo(filename).Duration;
%creating an object for writing a video to it
v = VideoWriter(outFilename);
open(v);
%writing first frame to video
videoOut = insertObjectAnnotation(videoFrame,'rectangle',BBox,'object');
writeVideo(v,videoOut);
minError = inf;
%the process of tracking the selected image
frameNumber=0;

%% Main loop
waitBarObject = waitbar(frameNumber,'Please wait...');
while ~isDone(videoFileReader) %untill video is finished
    waitbar(frameNumber/numberOfFrames,waitBarObject, sprintf('Please wait... Tracking in progress (%.3f%%)',frameNumber/numberOfFrames*100));
    frameNumber=frameNumber+1;
%for i=1:20
    % Extract the next video frame
    if RGB
        videoFrameDisplay = double(step(videoFileReader));
        videoFrame = convertRGB(videoFrameDisplay,Nbins);
    else
        videoFrameDisplay = double(rgb2gray(step(videoFileReader)));
        videoFrame = videoFrameDisplay;
    end
    %tracking the object
    [BBox, minError,searchBBox] = serachingAlgo(lastVideoFrame,videoFrame, BBox,Nbins);
    %save last frame
    lastVideoFrame = videoFrame;
    % Insert a bounding box around the object being tracked
    videoOut = insertObjectAnnotation(videoFrameDisplay,'rectangle',BBox,'object');
    videoOut = insertObjectAnnotation(videoOut,'rectangle',searchBBox,'searchErea');
    % Display the annotated video frame using the video player object
    step(videoPlayer, videoOut);
    % Write frame to output video
    writeVideo(v,videoOut);
end
disp(~isDone(videoFileReader));
close(waitBarObject);

%% Saving results
% Release resources
release(videoFileReader);
release(videoPlayer);
% Close output video
close(v);
command = strcat('"C:\\Program Files (x86)\\Windows Media Player\\wmplayer.exe" "', which(outFilename), '"');
system(command);













