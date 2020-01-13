function a = adsr_gen(target,gain,duration,a)

% Input
% target - vector of attack, sustain, release target values
% gain - vector of attack, sustain, release gain values
% duration - vector of attack, sustain, release durations in ms
% Output
% a - vector of adsr envelope values

fs = 16000;
fsd = fs/a;
a = zeros(fsd,1); % assume 1 second duration ADSR envelope
duration = round(duration./1000.*fsd); % envelope duration in samp

% Attack phase

start = 2;
stop = duration(1);

for n = [start:stop]
a(n) = target(1)*gain(1) + (1.0 - gain(1))*a(n-1);
end

% Sustain phase

start = stop + 1;
stop = start + duration(2);
for n = [start:stop]
a(n) = target(2)*gain(2) + (1.0 - gain(2))*a(n-1);
end

% Release phase

start = stop + 1;
stop = fsd;
for n = [start:stop]
a(n) = target(3)*gain(3) + (1.0 - gain(3))*a(n-1);
end;
