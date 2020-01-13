function x = singen( f,fs,duration )
% Generating a sine wave.
n = [0:(fs*duration)-1]';
x = sin(2*pi*n*f/fs);
end

