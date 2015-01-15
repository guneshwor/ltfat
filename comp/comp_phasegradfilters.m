function [hg,dg,g]=comp_phasegradfilters(g,a,L)

% Number of filters
M = numel(g);

% Precompute filters for length L if not done already
g = comp_filterbank_pre(g,a,L,100);

% Divide filters to time domain and frequency domain groups
mFreqBl = 1:M;
mTime = mFreqBl(cellfun(@(gEl) isfield(gEl,'h'),g(:))>0);
mFreqBl(mTime) = [];
mFreqL = mFreqBl(cellfun(@(gEl) isfield(gEl,'H') && numel(gEl.H) == L,g)>0);
mFreqBl(mFreqL) = [];

% For FIR/full-length frequency response filters, compute center frequency
if numel(mFreqBl) < M
    cfreq = zeros(M,1);
    tempind = [mTime,mFreqL];
    cfreq(tempind) = round(L/2*cent_freqs(g(tempind),L));
end;

% Determine impulse response or transfer function length

Lg = L*ones(M,1);
Lg(mTime) = cellfun(@(gEl) length(gEl.h),g(mTime));
Lg(mFreqBl) = cellfun(@(gEl) length(gEl.H),g(mFreqBl));

hg = g;
dg = g;
fftind = fftindex(L,0); % Set Nyquist frequency to 0!

%% ------ algorithm starts --------------------

% Construct time/frequency weighted versions of filters
% defined on the time side

for mId = mTime
    % Compute time weighted version.
    tempind = (g{mId}.offset:Lg(mId)+g{mId}.offset-1).';
    dg{mId}.h = tempind.*g{mId}.h;
    
    % Compute frequency weighted version.
    gH = comp_transferfunction(g{mId},L);
    hg{mId}.H = circshift(fftind,cfreq(mId)).*gH;
    hg{mId}=rmfield(hg{mId},'h');
    hg{mId}=rmfield(hg{mId},'offset');
    hg{mId}.foff = 0;
end;

% Construct time/frequency weighted versions of bandlimited filters
% defined on the frequency side

for mId = mFreqBl
    % Compute frequency weighted version.
    tempind = [L-floor(Lg(mId)/2)+1:L, ...
        1:ceil(Lg(mId)/2)];
    hg{mId}.H = fftind(tempind).*g{mId}.H;
    
    % Compute time weighted version.
    % The code below is a quick and dirty version of
    %     longg = fftshift(g{mId}.H);
    %     dg2{mId}.H = fftshift(pderiv(longg,[],Inf)/(2*pi));
    n=fftindex(Lg(mId),0);
    dg{mId}.H = L/Lg(mId)*real(fftshift( ...
        ifft(1i.*n.*fft(fftshift(g{mId}.H)))));
end;

% Construct time/frequency weighted versions of full-length filters
% defined on the frequency side

for mId = mFreqL
    % Compute frequency weighted version.
    hg{mId}.H = circshift(fftind,cfreq(mId)).*g{mId}.H;
    
    % Compute time weighted version.
    dg{mId}.H = real(ifft(1i.*fftind.*fft(g{mId}.H)));
end;