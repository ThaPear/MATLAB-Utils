function repeatcolormap(hAx, N, colormap)
    if(nargin < 3)
        colormap = hAx.ColorOrder;
    end
    hAx.ColorOrder = reshape(repmat(colormap, 1, N).', [], N*7).';
end