function s = integralParseArgs(varargin)
%INTEGRALPARSEARGS  Parse optional arguments to INTEGRAL.

%   Copyright 2007-2013 The MathWorks, Inc.

global sv;
if(isempty(sv))
    p = inputParser;
    %#ok<*NVREPL> % 'addParamValue' is not recommended. Use 'addParameter' instead.
    p.addParamValue('AbsTol',1e-10,@validateAbsTol);
    p.addParamValue('RelTol',1e-6,@validateRelTol);
    p.addParamValue('Waypoints',[],@validateWaypoints);
    p.addParamValue('ArrayValued',false,@validateArrayValued);
    p.parse(varargin{:});
    sv = p.Results;
    sv.ArrayValued = logical(sv.ArrayValued);
    sv.Rule = Gauss7Kronrod15;
    sv.InitialIntervalCount = 10;
    sv.Persistence = 1;
    sv.ThrowOnFail = false;
end

s = sv;
if(nargin > 1)
    s.Waypoints = varargin{2};
end
if(nargin > 2)
    error('Cannot handle arguments other than ''Waypoints''');
end

%--------------------------------------------------------------------------

function p = validateAbsTol(x)
if ~(isfloat(x) && isscalar(x) && isreal(x) && x >= 0)
    error(message('MATLAB:integral:invalidAbsTol'));
end
p = true;

%--------------------------------------------------------------------------

function p = validateRelTol(x)
if ~(isfloat(x) && isscalar(x) && isreal(x) && x >= 0)
    error(message('MATLAB:integral:invalidRelTol'));
end
p = true;

%--------------------------------------------------------------------------

function p = validateWaypoints(x)
if ~(isvector(x) || isequal(x,[])) || any(~isfinite(x))
    error(message('MATLAB:integral:invalidWaypoints'));
end
p = true;

%--------------------------------------------------------------------------

function p = validateArrayValued(x)
if ~(isscalar(x) && ...
        (islogical(x) || ...
        (isnumeric(x) && (x == 0 || x == 1))))
    error(message('MATLAB:integral:invalidArrayValued'));
end
p = true;

%--------------------------------------------------------------------------
