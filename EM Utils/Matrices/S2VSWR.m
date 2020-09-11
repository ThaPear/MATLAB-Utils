function [VSWR] = S2VSWR(S)

if(isstruct(S))
    S = S.s11;
end

VSWR = (1 + abs(S)) ./ (1 - abs(S));