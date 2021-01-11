function hist = imhistV2(I,Nbins,config)
    persistent weights;
    hist = zeros(Nbins,1);
    if config=="calcWeights" && isempty(weights)
            disp("calc weights");
            weights = zeros(size(I,1),size(I,2));
            roiX = size(I,1)/2;
            roiY = size(I,2)/2;
            maxR = sqrt(roiX^2+roiY^2);
            for x=1:size(I,1)
                for y=1:size(I,2)
                    r = sqrt((roiX-x)^2 + (roiY-y)^2);
                    weights(x,y) = (maxR-r)/maxR;
                end
            end
    end
    for x=1:size(I,1)
        for y=1:size(I,2)
            val = int16(I(x,y)* Nbins)+1;
            hist(val) = hist(val)+ weights(x,y);
        end
    end
    hist = weights;
end