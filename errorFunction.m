function error = errorFunction(I1,I2,Nbins)
%% Taking 2 images and computing error according to histogram menipulations
    %v1
    hist1 = imhist(I1,Nbins);
    hist2 = imhist(I2,Nbins);
    %v2
    %hist1 = myImHist(I1);
    %hist2 = myImHist(I2);
    error = hist1 - hist2;
    error = error.^2;
    error = sum(error);
end

function hist = myImHist(I)
    


end