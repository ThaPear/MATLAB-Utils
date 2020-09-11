classdef SpectralGF
    methods(Static)
        function [Gmat] = matrixform(G)
            % | 1,1  1,2 |    | xx xy |
            % | 2,1  2,2 |    | yx yy |
            % | 3,1  3,2 |    | zx zy |
            
            Gmat = zeros([3, 2, size(GF.xx)]);
            Gmat(1,1,:) = GF.xx(:);
            Gmat(1,2,:) = GF.yx(:);
            Gmat(2,1,:) = GF.xy(:);
            Gmat(2,2,:) = GF.yy(:);
            Gmat(3,1,:) = GF.xz(:);
            Gmat(3,2,:) = GF.yz(:);
            
        end
        function [Gej] = ej(zeta, k, kx, ky, vtm, vte, itm, ite)
            kr = sqrt(kx.^2 + ky.^2);
            
            kr((kx == 0) & (ky == 0)) = 1; % Prevents nan due to 0/0
            
            Gej.xx = - (vtm .* kx.^2 + vte .* ky.^2) ./ kr.^2;
            Gej.yx =   ((vte - vtm) .* kx .* ky)     ./ kr.^2;
            Gej.zx =   zeta .* (kx ./ k) .* itm;
            Gej.xy =   ((vte - vtm) .* kx .* ky)     ./ kr.^2;
            Gej.yy = - (vte .* kx.^2 + vtm .* ky.^2) ./ kr.^2;
            Gej.zy =   zeta .* (ky ./ k) .* itm;
        end
        function [Ghj] = hj(zeta, k, kx, ky, vtm, vte, itm, ite)
            kr = sqrt(kx.^2 + ky.^2);
            
            kr((kx == 0) & (ky == 0)) = 1; % Prevents nan due to 0/0
            
            Ghj.xx = - ((ite - itm) .* kx .* ky)     ./ kr.^2;
            Ghj.yx =   (itm .* kx.^2 + ite .* ky.^2) ./ kr.^2;
            Ghj.zx =   (ky ./ (k .* zeta)) .* vte;
            Ghj.xy =   (ite .* kx.^2 + itm .* ky.^2) ./ kr.^2;
            Ghj.yy =   ((ite - itm) .* kx .* ky)     ./ kr.^2;
            Ghj.zy =   (kx ./ (k .* zeta)) .* vte;
        end
        function [Ghm] = hm(zeta, k, kx, ky, vtm, vte, itm, ite)
            kr = sqrt(kx.^2 + ky.^2);
            
            kr((kx == 0) & (ky == 0)) = 1; % Prevents nan due to 0/0
            
            Ghm.xx = - (ite .* kx.^2 + itm .* ky.^2) ./ kr.^2;
            Ghm.yx = - ((ite - itm) .* kx .* ky)     ./ kr.^2;
            Ghm.zx =   (kx ./ (k .* zeta)) .* vte;
            Ghm.xy = - ((ite - itm) .* kx .* ky)     ./ kr.^2;
            Ghm.yy = - (itm .* kx.^2 + ite .* ky.^2) ./ kr.^2;
            Ghm.zy =   (ky ./ (k .* zeta)) .* vte;
        end
        function [Gem] = em(zeta, k, kx, ky, vtm, vte, itm, ite)
            kr = sqrt(kx.^2 + ky.^2);
            
            kr((kx == 0) & (ky == 0)) = 1; % Prevents nan due to 0/0
            
            Gem.xx = - ((vte - vtm) .* kx .* ky)     ./ kr.^2;
            Gem.yx =   (vte .* kx.^2 + vtm .* ky.^2) ./ kr.^2;
            Gem.zx = - zeta .* (kx ./ k) .* itm;
            Gem.xy = - (vte .* ky.^2 + vtm .* kx.^2) ./ kr.^2;
            Gem.yy = - ((vtm - vte) .* kx .* ky)     ./ kr.^2;
            Gem.zy =   zeta .* (kx ./ k) .* itm;
        end
    end
end