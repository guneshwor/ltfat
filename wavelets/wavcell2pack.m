function [cvec,Lc] = wavcell2pack(ccell,varargin)
%WAVCELL2PACK Changes wavelet coefficients storing format
%   Usage:  [cvec,Lc] = wavcell2pack(ccell);
%           [cvec,Lc] = wavcell2pack(ccell,dim);
%
%   Input parameters:
%         ccell    : Coefficients stored in a collumn cell-array.
%         dim      : Dimension along which the data were transformed. 
%
%   Output parameters:
%         cvec     : Coefficients in packed format.
%         Lc       : Vector containing coefficients lengths.
%
%   `[cvec,Lc] = wavcell2pack(ccell)` assembles a column vector or a matrix
%   *cvec* using elements of the cell-array *ccell* in the following
%   manner::
%
%      cvec(1+sum(Lc(1:j-1)):sum(Lc(1:j),:)=ccell{j};
%
%   where *Lc* is a vector of length `numel(ccell)` containing number of
%   rows of each element of *ccell*.
%
%   `[cvec,Lc] = wavcell2pack(ccell,dim)` with *dim==2* returns a
%   transposition of the previous.
%
%   See also: wavpack2cell, fwt, wfbt, wpfbt

% AUTHOR: Zdenek Prusa

if(nargin<1)
    error('%s: Too few input parameters.',upper(mfilename));
end

definput.keyvals.dim = 1;
[flags,kv,dim]=ltfatarghelper({'dim'},definput,varargin);
if(dim>2)
    error('%s: Multidimensional data is not accepted.',upper(mfilename));
end

% Actual computation
Lc = cellfun(@(x) size(x,1), ccell);
cvec = cell2mat(ccell);

% Reshape back to rows
if(dim==2)
    cvec = cvec.';
end



