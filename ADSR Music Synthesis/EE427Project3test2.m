%% Project 3 ADSR Envelope music synthesis
%  By Christopher W. Fingers and Alexander Bolton
%  Professor Moussavi
%  EE 427 Speech Signal Processing

%  The music used was the first 10 seconds of the audiotrack "His Theme"
%  from the video game Undertale.  

% Define our ADSRs' target, gain and duration(whole) values.
target = [ 1, 0.06, 0.05];
whole = [50, 650 , 300]
gain_whole = [.02*exp(-1), 0.001, 0.0005];

%  Dependent on quarter and dot quarter notes from song, the duration of
%  the signal will decrease from the length of a whole note by the length
%  of the note.
quarter = whole/4;
dot_quart = quarter*(3/2);

% Define the sampling frequency and the frequencies used in the song.
fs = 16000;
frequency = [369.994, 554.365, 493.883, 466.164, 622.254];

%  Adsr is created for both quarter and dot quarter note with a new
%  variable, a, used to represent the type of note that is being
%  represented.
 adsr_quarter = adsr_gen(target,gain_whole,quarter,4);
 adsr_quarter_dot = adsr_gen(target,gain_whole,dot_quart,8/3);

 % using singen the note values are calculated out with the correct 
 % duration for each signal. 
fsharp = singen(frequency(1), fs, 0.25);    
c = singen(frequency(2),fs,0.25);
cdot = singen(frequency(2),fs,3/8);
b = singen(frequency(3),fs,0.25);
bdot = singen(frequency(3),fs,3/8);
a = singen(frequency(4),fs,3/8);
dsharp = singen(frequency(5),fs,0.25);


%  The envelope and signal are multiplied.
fsound = adsr_quarter.*fsharp;
csound = adsr_quarter.*c;
cdotsound = adsr_quarter_dot.*cdot;
bsound = adsr_quarter.*b;
bdotsound = adsr_quarter_dot.*bdot;
asound = adsr_quarter_dot.*a;
dsound = adsr_quarter.*dsharp;

% Define each verse Appropriately.  
verse1 = [fsound; csound; bsound; fsound; asound; asound; bsound]; 
verse2 = [bsound; fsound; bsound; fsound; asound; asound; bsound];
verse3 = [bsound; fsound; bsound; dsound; cdotsound;bdotsound;csound]; 

%n = 1:3
%fharm(n) = 2*singen(frequency(1)*nmfsm0.25)

% Standard plot for the quarter note adsr and the quarter dot note adsr
% envelope.
figure(1)
plot(adsr_quarter);
title('ADSR Quarter Envelope');
xlabel('Samples (n)');
ylabel('Amplitude');
figure(2)
plot(adsr_quarter_dot);
title('ADSR Quarter Dot Envelope');
xlabel('Samples (n)');
ylabel('Amplitude');

plot(fsharp)

% Play out the audio in 2 second blocks.
 soundsc(verse1,fs)
 pause(2)
 soundsc(verse2,fs)
 pause(2)
 soundsc(verse1,fs)
 pause(2)
 soundsc(verse3,fs)
