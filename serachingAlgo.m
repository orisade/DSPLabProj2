function [newBBox, newMinError,searchBBox] = serachingAlgo(lastVideoFrame, videoFrame, BBox,Nbins)
    %% searching function
	newBBox = BBox;
	newMinError = inf;
    bound = 20;
	%initialize histogram
	x = int16(BBox(1));
	y = int16(BBox(2));
	w = int16(BBox(3));
	h = int16(BBox(4));
	%ROICenter = [x+w/2 y+h/2];
    %% Searching algorithem
    Object = lastVideoFrame(y:y+h-1, x:x+w-1);
    [y_max, x_max] = size(videoFrame);
    x_max = min([x+bound, x_max-w-1]);
    x_min = max([1,x-bound]);
    y_max = min([y+bound, y_max-h-1]);
    y_min = max([1,y-bound]);
    searchBBox = [x_min, y_min, x_max-x_min+w, y_max-y_min+h];
    if x_min >= x_max || y_min >= y_max
        disp('min is bigger than max!');
        return
    end
	%seraching in a radius of 'bound' around the selected image (BBox)
   errorFunction(Object,0,"loadHist",Nbins);
    for x=x_min:x_max 
		for y=y_min:y_max
                tmpImage = videoFrame(y:y+h-1, x:x+w-1);
			error = errorFunction(0, tmpImage, "",Nbins);
			if error < newMinError
				newMinError = error;
				newBBox = [x y w h];
			end
		end
    end
end	%end function