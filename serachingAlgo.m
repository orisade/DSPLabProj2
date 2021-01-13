function [newBBox, searchBBox] = serachingAlgo(lastVideoFrame, videoFrame, BBox,bound,Nbins)
    % searching the most similar (MSE meaning) object to the one in the
    % lastViodoFrame (at BBox) in fixed search box around the original BBox.
    % Returning the new object BBox and search BBox we used.
    %% intialize 
    newBBox = BBox;
	x = int16(BBox(1));
	y = int16(BBox(2));
	w = int16(BBox(3));
	h = int16(BBox(4));
    Object = lastVideoFrame(y:y+h-1, x:x+w-1);
    
    %% finding search BBox - radius of 'bound' around the selected image (BBox)
    [y_max, x_max] = size(videoFrame);
    x_max = min([x+bound, x_max-w-1]);
    x_min = max([1,x-bound]);
    y_max = min([y+bound, y_max-h-1]);
    y_min = max([1,y-bound]);
    searchBBox = [x_min, y_min, x_max-x_min+w, y_max-y_min+h];
    
	%% seraching for new object with smallest error to the original object
    newMinError = inf;
    errorFunction(Object,0,"loadHist",Nbins);   %loading hist for better performance
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