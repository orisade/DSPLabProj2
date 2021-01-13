%%Signal Processing Laboratory - Project 2 - task 9
%Ori Sade - 318262128
%Liav Cohen - 209454693
clc;
clear;
close all;
%% user inputs
filename = 'Fox.wmv';
outFilename = 'results\\output.avi';
Nbins=16;   %for RGB this value is equal to Nbins^3 {RGB matrix}.
RGB = false;
bound = 20;
%% Initialization - reading first Image and select object
%reading a single image from video according to RGB or GrayScale
videoFileReader = vision.VideoFileReader(which(filename));
if RGB
    videoFrame = double(step(videoFileReader));
    lastVideoFrame = convertRGB(videoFrame,Nbins);    
else
    videoFrame = double(rgb2gray(step(videoFileReader)));
    lastVideoFrame = videoFrame;
end
figure; imshow(videoFrame);
selcetedBox = drawrectangle();  %taking user imput of rectangle
BBox = selcetedBox.Position;    %extracting the BBox
close;

%% opening a video objects for playing the video and saving it
videoInfo = info(videoFileReader); % information about the source video
videoPlayer = vision.VideoPlayer('Position',[300 300 videoInfo.VideoSize+30]);
v = VideoWriter(outFilename);
open(v);
%writing first frame to video
videoOut = insertObjectAnnotation(videoFrame,'rectangle',BBox,'object');
writeVideo(v,videoOut);

%% Main loop
numberOfFrames = videoInfo.VideoFrameRate*mmfileinfo(filename).Duration;
frameNumber=0;
waitBarObject = waitbar(frameNumber,'Please wait...');
while ~isDone(videoFileReader) %untill video is finished
    waitbar(frameNumber/numberOfFrames,waitBarObject, sprintf('Please wait... Tracking in progress (%.3f%%)',frameNumber/numberOfFrames*100));
    frameNumber=frameNumber+1;
    % Extract the next video frame, save copy of rgb for display, in
    % grayscale this is the same one
    if RGB
        videoFrameDisplay = double(step(videoFileReader));
        videoFrame = convertRGB(videoFrameDisplay,Nbins);
    else
        videoFrameDisplay = double(rgb2gray(step(videoFileReader)));
        videoFrame = videoFrameDisplay;
    end
    %tracking the object
    [BBox, searchBBox] = serachingAlgo(lastVideoFrame,videoFrame, BBox,bound,Nbins);
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
close(waitBarObject);

%% Saving results
% Release resources
release(videoFileReader);
release(videoPlayer);
% Close output video
close(v);
%opening video file with wmplayer
command = strcat('"C:\\Program Files (x86)\\Windows Media Player\\wmplayer.exe" "', which(outFilename), '"');
system(command);













