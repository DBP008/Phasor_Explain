% var_peak e var_sigma sono l'ampiezza della variazione cioè il picco e la
% sigma possono variare entro un range di peak +- var_peak

function spettro = gaussian_n_noise(spettro, amplitude, var_amplitude, peak, var_peak, sigma, var_sigma, SNR)

%gaussmf altrimenti l'altezza del picco non è fissata ma cambia con
%sigmaaa!!!

% spettro = zeros(numel(spettro(),2);

% spettro(:,1) = spettro;

% r = a + (b-a).*rand(N,1).
% r = a + (b-a)*rand

% Usavano distribuzione uniforme
% peak = peak + (var_peak + 2*var_peak*rand);
% sigma = sigma + max_sigma*rand;
% amplitude = amplitude + max_amplitude*rand;

if sigma == 0
    spettro(spettro(:,1)==peak,2) = spettro(spettro(:,1)==peak,2) + 1;
else
peak = peak + var_peak*randn;
sigma = sigma + var_sigma*abs(randn);

amplitude = amplitude + var_amplitude*abs(randn);

if nargin > 7
    SNR_dB = 10*log10(SNR);
    
    spettro(:,2) = spettro(:,2)+ awgn(amplitude*gaussmf(spettro(:,1), [sigma peak]), SNR_dB, 'measured');
else
    spettro(:,2) = spettro(:,2) + amplitude*gaussmf(spettro(:,1), [sigma peak]);
end
end

    spettro(spettro(:,2)<0,2) = 0;
    

end