function error = errorFunction(I1,I2,config)
%% Taking 2 images and computing error according to histogram menipulations
    persistent hist1;
    Nbins = 16; %default is 256
    b=0.25;
    v2=false;
    if config == "loadHist"
        if v2
            hist1 = imhistV2(I1,Nbins,"calcWeights");
        else
            hist1 = imhist(I1,Nbins);
        end
        return;
    end
    if v2
        hist2 = imhistV2(I2,Nbins, "");
    else
        hist2 = imhist(I2,Nbins);
    end
    %v2
    %hist1 = myImHist(I1);
    %hist2 = myImHist(I2);
    error = (sum((hist1 - hist2).^2))*(1-b);
end
%Y[n] = Y[x-1]*b + X[n]*(1-b) -> where b=0.25



