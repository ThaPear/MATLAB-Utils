function [hAxImage, hAxContour, varargout] = imagecontour(hFig, X, Y, V, contours, varargin)
    usepcolor = 0;
    useimagesc = 0;
    addcolorbar = 0;
    if(nargin > 5)
        skipi = 0;
        for(i = 1:nargin-5)
            if(skipi)
                skipi = skipi - 1;
                continue;
            end
            arg = varargin{i};
            switch(lower(arg))
                case 'pcolor'
                    usepcolor = 1;
                case 'imagesc'
                    useimagesc = 1;
                case 'colorbar'
                    addcolorbar = 1;
            end
        end
    end
    delete(hFig.CurrentAxes);
    varargout = {};
    
    hAxImage = axes(hFig);
    if(usepcolor)
        im = pcolor(X, Y, V);
    elseif(useimagesc)
        im = imagesc(X, Y, V);
    else
        im = image(X, Y, V);
    end
    hAxImage.YDir = 'normal';
    
    if(addcolorbar)
        varargout = [varargout, {colorbar}];
    end

    hAxContour = axes(hFig);
    contour(X, Y, V, contours, 'ShowText', 'on');
    hAxContour.XTick = []; hAxContour.YTick = [];
    hAxContour.Position = hAxImage.Position;
    hAxImage.Position = hAxContour.Position;
    hAxContour.Color = 'none';
    linkaxes([hAxImage,hAxContour])
    colormap(hAxContour, 'cool');
    colormap(hAxContour, flipud(colormap(hAxContour)));
end