function fr = icqt(c,g,shift,Ls,dual)
%ICQT  Constant-Q nonstationary Gabor synthesis
%   Usage: fr = icqt(c,g,shift,Ls,dual)
%          fr = icqt(c,g,shift,Ls)
%          fr = icqt(c,g,shift)
%
%   Input parameters: 
%         c         : Transform coefficients (matrix or cell array)
%         g         : Cell array of Fourier transforms of the analysis 
%                     windows
%         shift     : Vector of frequency shifts
%         Ls        : Original signal length (in samples)
%         dual      : Synthesize with the dual frame
%   Output parameters:
%         fr        : Synthesized signal (Channels are stored in the 
%                     columns)
%
%   Given the cell array *c* of non-stationary Gabor coefficients, and a 
%   set of filters *g* and frequency shifts *shift* this function computes 
%   the corresponding constant-Q synthesis.
%
%   If *dual* is set to 1 (default), an attempt is made to compute the 
%   canonical dual frame for the system given by *g*, *shift* and the size 
%   of the vectors in *c*. This provides perfect reconstruction in the 
%   painless case, see the references for more information.
% 
%   This is just a dummy routine calling |insdgfb|.
%
%   See also:  cqt
% 
%   References:  dogrhove11 dogrhove12

% Author: Nicki Holighaus
% Date: 10.04.13

if ~exist('dual','var')
    dual = 1;
end

fr = comp_insdgfb(c,g,shift,Ls,dual);