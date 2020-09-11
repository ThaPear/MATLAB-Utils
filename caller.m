function [ret] = caller(result)
    % result: <empty>, returns struct with all results below
    %         'filename', returns filename          e.g. 'caller.m'
    %         'fullpath', returns filename and path e.g. 'c:\myfolder\caller.m'
    %         'path', returns path                  e.g. 'c:\myfolder\'
    %         'name', returns name                  e.g. 'caller'
    %         'line', returns line                  e.g. 10
    
    if(nargin < 1)
        result = '';
    end
    
    ST = dbstack('-completenames');
    if(length(ST) > 2 && ~isempty(ST(3).file))
        ST2 = dbstack;

        obj = struct();
        obj.filename = ST2(3).file;
        obj.fullpath = ST(3).file;
        obj.path = ST(3).file(1:end-length(obj.filename));
        obj.name = ST(3).name;
        obj.line = ST(3).line;
    end
    switch(result)
        case 'filename'
            ret = obj.filename;
        case 'fullpath'
            ret = obj.fullpath;
        case 'path'
            ret = obj.path;
        case 'name'
            ret = obj.name;
        case 'line'
            ret = obj.line;
        otherwise 
            ret = obj;
    end
end