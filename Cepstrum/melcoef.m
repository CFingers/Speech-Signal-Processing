%% MFCC calculations
function [coefs, periodogram] = melcoef(signal,fs)

% Define our overlap values.
nSamples = floor(fs*.025);
overlap = ceil(fs*0.01);
nFrames = ceil(length(signal)/(nSamples-overlap));

%  Zero pad the signal so that it matches up with original signal.
padding = ((nSamples-overlap)*nFrames)-length(signal);
if padding > 0
    signal = [transpose(signal),zeros(1,padding)];
else
    signal = transpose(signal);
end 
segment = zeros(nSamples,nFrames);
start = 1;
for i= 1:nFrames
    segment(:,i) = signal(start:start+nSamples-1);
    start = (nSamples - (overlap+5))*i;
end

%  Calculate the periodgram and mult with a hamming signal.
nfft = 512;
periodogram = zeros(nFrames,nfft/2 +1);
for i = 1:nFrames
    x= segment(:,i).*hamming(nSamples);
    spectrum = fftshift(fft(x,nfft));
    periodogram(i,:) = abs(spectrum(nfft/2:end));
end

%  Define number of filterbanks and calculate.
numfilts = 20;

fbank = melfb(numfilts,nfft,fs);

%  Plot filter banks.
for a = 1:numfilts
    plot(fbank(a,:));
    title('Mel Filter Banks');
    xlabel('Samples');
    ylabel('Magnitude');
    hold on;
end
hold off

mel_coef = zeros(numfilts, nFrames);
for i = 1:numfilts
    for j = 1:nFrames
        % The function sum with 'all' at the end was found to not be
        % available in older versions of Matlab, such as version 2016a.  It
        % will inevitably give an error.
        mel_coef(i,j) = sum(periodogram(j,:).*fbank(i,:),'all');
    end
end

%  Calculate mel frequency coefficients.
     mel_coef_log = log10(mel_coef);
     coefs = dct(mel_coef_log,[],2);
     coefs(end,:) = [];
end