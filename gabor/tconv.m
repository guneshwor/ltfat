function h=tconv(f,g)
%TCONV  Twisted convolution
%   Usage:  h=tconv(f,g);
%
%   `tconv(f,g)` computes the twisted convolution of the square matrices
%   *f* and *g*.
%
%   Let `h=tconv(f,g)` for *f,g* being $L \times L$ matrices. Then *h* is given by
%
%   ..              L-1 L-1
%      h(m+1,n+1) = sum sum f(k+1,l+1)*g(m-k+1,n-l+1)*exp(-2*pi*i*(m-k)*l/L);
%                   l=0 k=0
%
%   .. math:: h\left(m+1,n+1\right)=\sum_{l=0}^{L-1}\sum_{k=0}^{L-1}f\left(k+1,l+1\right)g\left(m-k+1,n-l+1\right)e^{-2\pi i(m-k)l/L}
%
%   where $m-k$ and $n-l$ are computed modulo *L*.
%
%   If both *f* and *g* are of class `sparse` then *h* will also be a sparse
%   matrix. The number of non-zero elements of *h* is usually much larger than
%   the numbers for *f* and *g*. Unless *f* and *g* are very sparse, it can be
%   faster to convert them to full matrices before calling `tconv`. 
%
%   The routine |spreadinv| can be used to calculate an inverse convolution.
%   Define *h* and *r* by::
%
%     h=tconv(f,g);
%     r=tconv(spreadinv(f),h);
%
%   then *r* is equal to *g*.
%
%   See also:  spreadop, spreadfun, spreadinv


%   AUTHOR: Peter L. Søndergaard
%   TESTING: TEST_SPREAD
%   REFERENCE: REF_TCONV

error(nargchk(2,2,nargin));


if any(size(f)~=size(g))
  error('Input matrices must be same size.');
end;

if size(f,1)~=size(f,2)
  error('Input matrices must be square.');
end;

L=size(f,1);

if issparse(f) && issparse(g)
  
  % Version for sparse matrices.
  
  % precompute the Lth roots of unity
  % Optimization note : the special properties and symmetries of the 
  % roots of unity could be exploited to reduce this computation.
  % Furthermore here we precompute every possible root if some are 
  % unneeded. 
  temp=exp((-i*2*pi/L)*(0:L-1)');
  [rowf,colf,valf]=find(f);
  [rowg,colg,valg]=find(g);
  
  h=sparse(L,L);  
  for indf=1:length(valf)
    for indg=1:length(valg)
      m=mod(rowf(indf)+rowg(indg)-2, L);
      n=mod(colf(indf)+colg(indg)-2, L);
      h(m+1,n+1)=h(m+1,n+1)+valf(indf)*valg(indg)*temp(mod((m-(rowf(indf)-1))*(colf(indf)-1),L)+1);
    end
  end

  
else

  % The conversion to 'full' is in order for Matlab to work.
  f=ifft(full(f))*L;
  g=ifft(full(g))*L;
  
  Tf=comp_col2diag(f);
  Tg=comp_col2diag(g);
  
  Th=Tf*Tg;
  
  h=spreadfun(Th);

end;
