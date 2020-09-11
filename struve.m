function f = struve(n, x)
% Calculates the Struve Function
%
% from: https://www.univie.ac.at/nuhag-php/janssen/data/p227.pdf


    switch(n)
        case 0
            f = besselj(1,x) + (7-20/pi).*(1-cos(x))./x + (36/pi-12).*(sin(x)-x.*cos(x))./x.^2;
        case 1
            f = 2/pi - besselj(0, x) + (16/pi-5).*sin(x)./x + (12-36/pi).*(1-cos(x))./x.^2;
        otherwise
            warning('Struve for n > 1 is inaccurate.');
            f = -struve(n-2, x) + 2*(n-1)./x.*struve(n-1, x) + (x./2).^(n-1) ./ (sqrt(pi).*gamma(n-1+3/2));
    end
    
    
    % Supposedly more accurate, but doesn't appear to be. Likely due to the approximations in the
    % constants below.
%     c1 = 0.9846605676;
%     c2 = 1.7825674761;
%     d1 = -0.8153693250;
%     d2 = -1.7189527653;
%     t0 = 0.8830472903;
%     switch(n)
%         case 0
%             A0 = 2 / pi * c2; % 1.134817700;
%             B0 = 2 / pi * d2; % -1.0943193181;
%             C0 = 2 / pi * (d2 - d1); % -0.5752390840;
%             f = besselj(1,x) + A0 .* (1-cos(x))./x + B0 .* (sin(x) - x.*cos(x)) ./ x.^2 + C0 .* (x .* t0 - sin(x) .* t0) ./ x.^2;
%         case 1
%             A1 = 2 / pi * (c2 + d2); % 0.0404983827;
%             B1 = -2 / pi * d2; % 1.0943193181;
%             C1 = 2 / pi * (d2 - d1); % -0.5752390840;
%             f = 2/pi - besselj(0, x) + A1 .* sin(x)./x + B1 .* (1-cos(x))./x.^2 + C1 .* (1-cos(x).*t0) ./ x.^2;
%         otherwise
%             f = -struve(n-2, x) + 2*(n-1)./x.*struve(n-1, x) + (x./2).^(n-1) ./ (sqrt(pi).*gamma(n-1+3/2));
%     end
    
    f(x == 0) = 0;
end