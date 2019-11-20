function dispex(varargin)
    % Get the caller function.
    ST = dbstack('-completenames');
    file = ST(2).file;
    file = strrep(file, '\', '/');
    line = ST(2).line;
    href = ['<a href="matlab: opentoline(''', file, ''',', num2str(line), ')"><<</a> '];
    
    % Prepend the link
    msg = varargin{1};
    msg = [href, msg];
    
%     if(nargin == 1)
%         % We're used as a normal disp.
%         disp(msg);
%     else
        % Assume fprintf style.
        fprintf(msg, varargin{2:end});
%     end
end