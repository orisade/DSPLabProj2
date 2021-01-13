function newI=convertRGB(I,Nbins)
        maxPixel = Nbins*Nbins^0+Nbins*Nbins^1+Nbins*Nbins^2;
        newI = zeros(size(I,1),size(I,2));
        for x=1:size(I,1)
            for y=1:size(I,2)
                R = int16(I(x,y,1)*Nbins); G = int16(I(x,y,2)*Nbins); B = int16(I(x,y,3)*Nbins);
                newI(x,y) = R+G*Nbins+B*Nbins^2;
                newI(x,y) = newI(x,y)/maxPixel;
            end
        end
end