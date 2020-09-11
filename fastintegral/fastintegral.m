function Q = fastintegral(fun,a,b,varargin)
% Does the same as integral, except it uses a custom integralParseArgs, which is significantly
% faster than the built-in version.

% Validate the first three inputs.
narginchk(3,inf);
if ~isa(fun,'function_handle')
    error(message('MATLAB:integral:funArgNotHandle'));
end
if ~(isscalar(a) && isfloat(a) && isscalar(b) && isfloat(b))
    error(message('MATLAB:integral:invalidEndpoint'));
end
opstruct = integralParseArgs(varargin{:});
Q = integralCalc(fun,a,b,opstruct);
