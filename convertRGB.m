function newI=convertRGB(I,Nbins)
%% converting RGB image to one dimention image where we have Nbins^3 colors
% those colored are mapped into [0,1]. Each R/G/B have Nbins shades. 
        maxPixel = Nbins*Nbins^0+Nbins*Nbins^1+Nbins*Nbins^2;   %Nbins^3-1
        newI = zeros(size(I,1),size(I,2));
        for x=1:size(I,1)
            for y=1:size(I,2)
                R = int16(I(x,y,1)*Nbins); G = int16(I(x,y,2)*Nbins); B = int16(I(x,y,3)*Nbins);
                newI(x,y) = R+G*Nbins+B*Nbins^2;    %R*Nbins^0 + G*Nbins^1 + B*Nbins^3
                newI(x,y) = newI(x,y)/maxPixel;     %mapping back to [0 1] value range
            end
        end
end