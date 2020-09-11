classdef ABCDMatrix
    properties
        A
        B
        C
        D
    end
    methods(Static)
        function abcd = identity()
            abcd = ABCDMatrix(1, 0, 0, 1);
        end
        
        function test()
            abcd1 = ABCDMatrix(1, 2, 3, 4);
            abcd2 = ABCDMatrix(4, 3, 2, 1);
            
            abcd3 = abcd1.mul(abcd2);           %#ok<NASGU>
            abcd4 = abcd1.invert().mul(abcd2);  %#ok<NASGU>
            
            [v1, i1] = abcd1.mul(1, 2);         %#ok<ASGLU>
        end
    end
    methods
        function this = ABCDMatrix(A, B, C, D)
            switch(nargin)
                case 1 % The first argument is an ABCD matrix.
                    this.A = A.A;
                    this.B = A.B;
                    this.C = A.C;
                    this.D = A.D;
                case 4 % Simply 4 specified paremeters.
                    this.A = A;
                    this.B = B;
                    this.C = C;
                    this.D = D;
                otherwise
                    error('%s::ABCDMatrix:\n\tInvalid number of constructor arguments.', mfilename);
            end
        end
        
        function bool = isidentity(this)
            bool = (this.A == 1) & ...
                   (this.B == 0) & ...
                   (this.C == 0) & ...
                   (this.D == 1);
        end
        
        function [varargout] = mul(this, ABCDorV2, I2)
            % Either takes a second ABCD matrix and multiplies with it, or multiplies with the given
            % voltage & current.
            switch(nargin)
                case 2
                    % Places the given matrix in series with this object.
                    ABCD = ABCDorV2;
                    %        |------|    |------|
                    %     -- |      | -- |      | -- 
                    % -->    | this |    | ABCD |    -->
                    %     -- |      | -- |      | -- 
                    %        |------|    |------|

                    % |--------------|
                    % | AA+BC  AB+BD |
                    % | CA+DC  CB+DD |
                    % |--------------|

                    result = ABCDMatrix(this.A .* ABCD.A + this.B .* ABCD.C, ...
                                        this.A .* ABCD.B + this.B .* ABCD.D, ...
                                        this.C .* ABCD.A + this.D .* ABCD.C, ...
                                        this.C .* ABCD.B + this.D .* ABCD.D);
                    varargout = {result};
                case 3
                    % |----|      |------| |----|      |-------------|
                    % | V1 |  --  | A  B | | V2 |  --  | A V2 + B I2 |
                    % | I1 |  --  | C  D | | I2 |  --  | C V2 + D I2 |
                    % |----|      |------| |----|      |-------------|
                    V2 = ABCDorV2;
                    V1 = this.A .* V2 + this.B .* I2;
                    I1 = this.C .* V2 + this.D .* I2;
                    varargout = {V1, I1};
            end
        end
        
        function [result] = invert(this)
            result = ABCDMatrix(  this.D ./ (this.A .* this.D - this.B .* this.C), ...
                                - this.B ./ (this.A .* this.D - this.B .* this.C), ...
                                - this.C ./ (this.A .* this.D - this.B .* this.C), ...
                                  this.A ./ (this.A .* this.D - this.B .* this.C));
        end
        
%         function [result] = parallel(this, ABCD)
%             % Places the given matrix in parallel with this object.
%             
%             %              |------|
%             %          /-- |      | --\
%             %         /    | this |    \
%             %        / /-- |      | --\ \
%             %     --/ /    |------|    \ \--
%             % -->    X                  X    -->
%             %     --\ \    |------|    / /--
%             %        \ \-- |      | --/ /
%             %         \    | ABCD |    /
%             %          \-- |      | --/
%             %              |------|
%             
%             
%         end
    end
end