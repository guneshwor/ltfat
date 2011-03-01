% LTFAT - Basic Fourier and DCT analysis.
%
%  Peter L. Soendergaard, 2008.
%
%  Basic Fourier analysis
%    DFT            -  Unitary discrete Fourier transform.
%    IDFT           -  Inverse of DFT.
%    FFTREAL        -  FFT for real valued signals.
%    IFFTREAL       -  Inverse of FFTREAL.
%    FFTINDEX       -  Index of positive and negative frequencies.
%
%  Simple operations on periodic functions
%    INVOLUTE       -  Involution.
%    PEVEN          -  Even part of periodic function.
%    PODD           -  Odd part of periodic function.
%    PCONV          -  Periodic convolution.
%    PFILT          -  Apply filter with periodic boundary conditions.
%    ISEVEN         -  Test if function is even.
%    MIDDLEPAD      -  Cut or extend even function.
%
%  Rotation in the TF-plane
%    HERMBASIS      -  Orthonormal basis of Hermite functions.
%    DFFT           -  The Discrete Fractional Fourier Transform.
%
%  Functions
%    EXPWAVE        -  Complex exponential wave.
%    PCHIRP         -  Periodic chirp.
%    SHAH           -  Shah distribution.
%    PHEAVISIDE     -  Periodic Heaviside function.
%    PRECT          -  Periodic rectangle function.
%    PSINC          -  Periodic sinc function.
%
%  Window functions
%    PGAUSS         -  Periodic Gaussian.
%    PSECH          -  Periodic SECH.
%    PHERM          -  Periodic Hermite functions.
%    PBSPLINE       -  Periodic B-splines.
%    FIRWIN         -  FIR windows (Hanning,Hamming,Blackman,...).
%    FIRKAISER      -  FIR Kaiser-Bessel window.
%    FIR2LONG       -  Extend FIR window to LONG window.
%    LONG2FIR       -  Cut LONG window to FIR window.
%    MAGRESP        -  Magnitude response plot.
%
%  Approximation of continous functions
%    FFTRESAMPLE    -  Fourier interpolation.
%    DCTRESAMPLE    -  Cosine interpolation.
%    PDERIV         -  Derivative of periodic function.
%
%  Cosine and Sine transforms.
%    DCTI           -  Discrete cosine transform type I
%    DCTII          -  Discrete cosine transform type II
%    DCTIII         -  Discrete cosine transform type III
%    DCTIV          -  Discrete cosine transform type IV
%    DSTI           -  Discrete sine transform type I
%    DSTII          -  Discrete sine transform type II
%    DSTIII         -  Discrete sine transform type III
%    DSTIV          -  Discrete sine transform type IV
%
%  For help, bug reports, suggestions etc. please send email to
%  ltfat-help@lists.sourceforge.net
