% ---- movelegend.m

function movelegend(hAx, pos)
%     hFig = gcf;
    switch(nargin)
        case 0
            pos = 'sw';
            hAx = gca;
        case 1
            pos = hAx;
            hAx = gca;
    end
    if(~isa(hAx, 'matlab.graphics.axis.Axes'))
        if(isa(hAx, 'matlab.ui.Figure'))
            hAx = hAx.CurrentAxes;
        elseif(isa(hAx, 'matlab.graphics.illustration.Legend'))
            hAx = hAx.Parent;
        else
            error('Invalid hAx type %s.\n', class(hAx));
        end
    end
    
    % Ensure the 'o' is at the end of the string.
    if(contains(pos, 'o'))
        pos(pos == 'o') = [];
        pos = [pos, 'o'];
    end
    
    hFig = hAx.Parent;
    hLeg = legend(hAx);
    hLeg.Units = hAx.Units;
    switch(sort(pos))
        case sort('n')
            hLeg.Position(1) = hAx.Position(1) + hAx.Position(3) / 2 - hLeg.Position(3) / 2;
            hLeg.Position(2) = hAx.Position(2) + hAx.Position(4) - hLeg.Position(4);
        case sort('ne')
            hLeg.Position(1) = hAx.Position(1) + hAx.Position(3) - hLeg.Position(3);
            hLeg.Position(2) = hAx.Position(2) + hAx.Position(4) - hLeg.Position(4);
        case sort('e')
            hLeg.Position(1) = hAx.Position(1) + hAx.Position(3) - hLeg.Position(3);
            hLeg.Position(2) = hAx.Position(2) + hAx.Position(4) / 2 - hLeg.Position(4) / 2;
        case sort('se')
            hLeg.Position(1) = hAx.Position(1) + hAx.Position(3) - hLeg.Position(3);
            hLeg.Position(2) = hAx.Position(2);
        case sort('s')
            hLeg.Position(1) = hAx.Position(1) + hAx.Position(3) / 2 - hLeg.Position(3) / 2;
            hLeg.Position(2) = hAx.Position(2);
        case sort('sw')
            hLeg.Position(1) = hAx.Position(1);
            hLeg.Position(2) = hAx.Position(2);
        case sort('w')
            hLeg.Position(1) = hAx.Position(1);
            hLeg.Position(2) = hAx.Position(2) + hAx.Position(4) / 2 - hLeg.Position(4) / 2;
        case sort('nw')
            hLeg.Position(1) = hAx.Position(1);
            hLeg.Position(2) = hAx.Position(2) + hAx.Position(4) - hLeg.Position(4);
        case sort('c')
            hLeg.Position(1) = hAx.Position(1) + hAx.Position(3) / 2 - hLeg.Position(3) / 2;
            hLeg.Position(2) = hAx.Position(2) + hAx.Position(4) / 2 - hLeg.Position(4) / 2;
        % Outside cases
        case sort('no')
            hLeg.Position(1) = hAx.Position(1) + hAx.Position(3) / 2 - hLeg.Position(3) / 2;
            hLeg.Position(2) = hAx.Position(2) + hAx.Position(4);
        case sort('neo')
            hLeg.Position(1) = hAx.Position(1) + hAx.Position(3);
            hLeg.Position(2) = hAx.Position(2) + hAx.Position(4);
        case sort('nneo')
            hLeg.Position(1) = hAx.Position(1) + hAx.Position(3) - hLeg.Position(3);
            hLeg.Position(2) = hAx.Position(2) + hAx.Position(4);
        case sort('eneo')
            hLeg.Position(1) = hAx.Position(1) + hAx.Position(3);
            hLeg.Position(2) = hAx.Position(2) + hAx.Position(4) - hLeg.Position(4);
        case sort('eo')
            hLeg.Position(1) = hAx.Position(1) + hAx.Position(3);
            hLeg.Position(2) = hAx.Position(2) + hAx.Position(4) / 2 - hLeg.Position(4) / 2;
        case sort('seo')
            hLeg.Position(1) = hAx.Position(1) + hAx.Position(3);
            hLeg.Position(2) = hAx.Position(2) - hLeg.Position(4);
        case sort('sseo')
            hLeg.Position(1) = hAx.Position(1) + hAx.Position(3) - hLeg.Position(3);
            hLeg.Position(2) = hAx.Position(2) - hLeg.Position(4);
        case sort('eseo')
            hLeg.Position(1) = hAx.Position(1) + hAx.Position(3);
            hLeg.Position(2) = hAx.Position(2);
        case sort('so')
            hLeg.Position(1) = hAx.Position(1) + hAx.Position(3) / 2 - hLeg.Position(3) / 2;
            hLeg.Position(2) = hAx.Position(2) - hLeg.Position(4);
        case sort('swo')
            hLeg.Position(1) = hAx.Position(1) - hLeg.Position(3);
            hLeg.Position(2) = hAx.Position(2) - hLeg.Position(4);
        case sort('sswo')
            hLeg.Position(1) = hAx.Position(1);
            hLeg.Position(2) = hAx.Position(2) - hLeg.Position(4);
        case sort('wswo')
            hLeg.Position(1) = hAx.Position(1) - hLeg.Position(3);
            hLeg.Position(2) = hAx.Position(2);
        case sort('wo')
            hLeg.Position(1) = hAx.Position(1) - hLeg.Position(3);
            hLeg.Position(2) = hAx.Position(2) + hAx.Position(4) / 2 - hLeg.Position(4) / 2;
        case sort('nwo')
            hLeg.Position(1) = hAx.Position(1) - hLeg.Position(3);
            hLeg.Position(2) = hAx.Position(2) + hAx.Position(4);
        case sort('nnwo')
            hLeg.Position(1) = hAx.Position(1);
            hLeg.Position(2) = hAx.Position(2) + hAx.Position(4);
        case sort('wnwo')
            hLeg.Position(1) = hAx.Position(1) - hLeg.Position(3);
            hLeg.Position(2) = hAx.Position(2) + hAx.Position(4) - hLeg.Position(4);
        otherwise
            disp('movelegend: Only ''n'', ''ne'', ''e'', ''se'', ''s'', ''sw'', ''w'', ''nw'', ''c'' are supported');
    end
    % Resize axes if necessary
    if(strcmpi(hLeg.Units, 'normalized'))
        figSize = [1 1];
    else
        figSize = hFig.Position(3:4);
    end
    if( hLeg.Position(3) > figSize(1) ...
        || hLeg.Position(4) > figSize(2))
        return;
    end
    % Check top
    if(hLeg.Position(2) + hLeg.Position(4) > figSize(2))
        diff = figSize(2) - (hLeg.Position(2) + hLeg.Position(4));
        hAx.Position(4) = hAx.Position(4) + diff;
        hLeg.Position(2) = hLeg.Position(2) + diff;
        drawnow;
        movelegend(pos);
    end
    % Check right
    if(hLeg.Position(1) + hLeg.Position(3) > figSize(1))
        diff = figSize(1) - (hLeg.Position(1) + hLeg.Position(3));
        hAx.Position(3) = hAx.Position(3) + diff;
        hLeg.Position(1) = hLeg.Position(1) + diff;
        drawnow;
        movelegend(pos);
    end
    % Check bottom
    if(hLeg.Position(2) < 0)
        diff = - hLeg.Position(2);
        hAx.Position(2) = hAx.Position(4) + diff;
        hAx.Position(4) = hAx.Position(4) - diff;
        hLeg.Position(2) = hLeg.Position(2) + diff;
        drawnow;
        movelegend(pos);
    end
    % Check left
    if(hLeg.Position(1) < 0)
        diff = - hLeg.Position(1);
        hAx.Position(1) = hAx.Position(3) + diff;
        hAx.Position(3) = hAx.Position(3) - diff;
        hLeg.Position(1) = hLeg.Position(1) + diff;
        drawnow;
        movelegend(pos);
    end
end