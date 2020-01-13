% Speaker Recognition Software Utilizing MFCC and VQLBG
% By. Alexander Bolton and Christopher Fingers
% Professor Moussavi  
% EE 427 

% Determines number of participants.
n = 8;
code = train(n);

 for i = 1:n
     % Create the graphs for each individual centroids(green) versus the
     % other plots(red).
     matrix = code{i};
     matrix = matrix(:,1:8);
     m= mean(matrix');
     
     figure()
     plot(m,'--g','Linewidth',4)
     hold on
     plot(matrix,'r');
     title('Centroid');
     legend('centroid','other')
 end

test(n , code)


%  When first demoed our group did not include the centroid graphs that are
%  now present and we tried to use live audio records with others.  In the
%  case of pre recorded audio the code works as intended.  The audio files
%  used were those provided by the project with the 8 different individuals
%  saying 0.

% References:
% An Automatic Speaker Recognition Software
% http://minhdo.ece.illinois.edu/teaching/speaker_recognition/
% Standford Speaker Recognition:
% https://ccrma.stanford.edu/~orchi/Documents/speaker_recognition_report.pdf
% Practical Cryptography:  Mel Frequency Cepstral Coefficient (MFCC)
% tutorial
% http://practicalcryptography.com/miscellaneous/machine-learning/guide-mel-frequency-cepstral-coefficients-mfccs/
