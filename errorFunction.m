function error = errorFunction(I1,I2,config,Nbins)
%% Taking 2 images and computing error according to MSE method.
%% loading hist1 for better performace, comparing always to hist1
    persistent hist1;
    if config == "loadHist" 
            hist1 = imhist(I1,Nbins);
        return;
    end
    
%% computing the MSE
    hist2 = imhist(I2,Nbins);
    error = sum((hist1(:) - hist2(:)).^2);
end


