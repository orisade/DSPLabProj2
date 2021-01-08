%%Signal Processing Laboratory - Project 2 - task 9
%Ori Sade - 318262128
%Liav Cohen - 209454693

%%Liav job - please create a ppt with ALL inforamtion about this project
%%Evegeny wants full description of the problem, the goal to solve it and the algorithem itself
%%Please do it by Sunday so we could have some progress bar over the project 



%%things to learn:
%need to find video database for matlab, rgb and grayscale (althogh we can generate grayscale from rgb)
%how to show Image and let the user select a rectangle
%	maybe: ROIBox = getPosition( imrect );
%creating an histogram trakcer (can be used from lab 7 ) - all process


%learn how the algorithem works and apply it manually for grayscale videos
% https://en.wikipedia.org/wiki/Color_histogram. 


%opening video for reading
videoFileReader = vision.VideoFileReader(which('rhinos.avi'));

%reading a single image from video - for start
videoFrame = step(videoFileReader);
figure; imshow(videoFrame);
selcetedBox = drawrectangle();
%getting user BBox
BBox = selcetedBox.Position;
%Create a tracker object.
tracker = vision.HistogramBasedTracker;
initializeObject(tracker, videoFrame, BBox(1,:));	%this is on hue but we need RGB

%opening a video object for playing the video
%videoInfo = info(videoFileReader); % information about the source video
%videoPlayer = vision.VideoPlayer('Position',[300 300 videoInfo.VideoSize+30]);

%creating an object for writing a video to it
%v = VideoWriter('output.avi');
%open(v);

%writing first frame to video
%writeVideo(v,videoOut);

%the process of tracking the selected image 
%while ~isDone(videoFileReader) %untill video is finished
 % Extract the next video frame
 %videoFrame = step(videoFileReader);
 % RGB -> HSV	%WE DON'T NEED IT
 %[hueChannel,~,~] = rgb2hsv(videoFrame); % discard saturation and value channels
 % Track the face using the Hue channel data	%NEED THE RGB
 %bbox = step(tracker, hueChannel);
 % Insert a bounding box around the object being tracked
 %videoOut = insertObjectAnnotation(videoFrame,'rectangle',bbox,'Face');
 % Display the annotated video frame using the video player object
 %step(videoPlayer, videoOut);
 % Write frame to output video
 %writeVideo(v,videoOut);
%end

% Release resources
%release(videoFileReader);
%release(videoPlayer);
% Close output video
%close(v);


%%regarding the manual run we can see full example in lab7. define it as function and test it





