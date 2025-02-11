function [G, S] = spectra_to_phasor(data, harmonic, black_level)
% Converte uno spettro come matrice Nx2 (lambda, intensit�) in un fasore
% con componenti Re = G e Im = S

G = 0;
S = 0;

if nargin < 3
    black_level = 0;
end

% Numero di righe
N = length(data(:,2));

I = norm(data(:,2),1);

%Set BlackLevel (blackLevel -> se il segnale minore di BL, metto a 0 il
%segnale in quella posizione)
for i = 1:N
   if data(i,2) < black_level
       data(i,2) = 0;
   end
end

% Implemento l'algoritmo della DFT per una singola armonica 
% Attenzione a farlo partire da zero! Però gli array in MATLAB partono da
% 1!


%     for k = 0:(N-1)
% %         if data(k+1,2) > black_level
%             I = I + data((k+1),2);
%             G = G + data((k+1),2)*cos(-2*pi*harmonic*k/N); 
%             S = S + data((k+1),2)*sin(-2*pi*harmonic*k/N);
% %         end
%     end
    
    for k = 1:N
%         if data(k+1,2) > black_level Ho annullato i data in entrata
            G = G + data(k,2)*cos(-2*pi*harmonic*(k-1)/N); 
            S = S + data(k,2)*sin(-2*pi*harmonic*(k-1)/N);
%         end
    end

G = G/I;
S = S/I;

if (isnan(G) || isnan(S))
    G = 0;
    S = 0;
end


% Ci mette un po' di più perché fa tutta la DFT
% FT = fft(data(:,2));
% 
% FT = FT ./ abs(FT(1));
%  G2 = real(FT(harmonic+1));
%  S2 = imag(FT(harmonic+1));








