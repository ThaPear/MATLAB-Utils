function legendlinelength(hAx, len)
% 
switch(nargin)
    case 0
        hAx = gca;
        len = 10;
    case 1
        if(isnumeric(hAx))
            len = hAx;
            hAx = gca;
        end
        if(ishandle(hAx))
            len = 10;
        end
end

if(~isa(hAx, 'matlab.graphics.axis.Axes'))
    if(isa(hAx, 'matlab.graphics.illustration.Legend'))
        hAx = hAx.Parent;
    else
        error('Invalid handle provided.');
    end
end

hLeg = legend(hAx);
hLeg.ItemTokenSize(1) = len;