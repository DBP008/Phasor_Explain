function cerchio_magico_data = ref_circle(lambda, harmonic, sub_lambda, sigma, congiungenti)
% Calcolo le coordinate (G,S) del cerchio magico
% La variabile "congiungenti" è un moltiplicatore


% Condizioni argomenti

if nargin < 2
    % Se NON specifico l'armonica, uso la prima
    harmonic = 1;
end

if nargin < 3
    % Se NON specifico un sottorange di lunghezze d'onda, uso il range
    % totale
    sub_lambda = lambda;
end

if sub_lambda == 0
    % Se passo un array VUOTO, uso l'intero range
    sub_lambda = lambda;
end

if nargin < 4
    % Se NON specifico la sigma, stampo il cerchio magico con delle delta
    sigma = 0;
end

if nargin < 5
    % Se NON specifico il numero di congiungenti, ne faccio solo 1.
    congiungenti = 0;
end

if (abs(lambda(1)-lambda(2))>.5)
    % Infittisco il range delle lambda
    lambda = min(lambda):0.5:max(lambda);
end

if (abs(sub_lambda(1)-sub_lambda(2))>.5)
    % Infittisco il sotto-range delle lambda
    sub_lambda = min(sub_lambda):0.5:max(sub_lambda);
end

% Salvo i parametri nella struttura "cerchio"
cerchio_magico_data.lambda = lambda;
cerchio_magico_data.harmonic = harmonic;
cerchio_magico_data.sub_lambda = sub_lambda;
cerchio_magico_data.sigma = sigma;
cerchio_magico_data.congiungenti = congiungenti;

% Creo una matrice nx2 dove nella prima colonna metto le lunghezze d'onda e
% nella seconda i valori di legno
spettro = zeros(numel(lambda), 2);
spettro(:,1) = lambda;

% Inizializzo gli array G e S
cerchio_magico_data.G = [];
cerchio_magico_data.S = [];
cerchio_magico_data.colormap = [];

for j = sigma
    for i = transpose(spettro(:,1))
        if i>=min(sub_lambda) && i<=max(sub_lambda)
            if(j==0)
                spettro(:,2) = 0;
                spettro((spettro(:,1)==i),2) = 1;
            else
                spettro(:,2) = normpdf(spettro(:,1), i, j);
            end
            
            [g, s] = spectra_to_phasor(spettro, harmonic, 0);
            
            sRGB = spectrumRGB(i);
            
            cerchio_magico_data.G = [cerchio_magico_data.G; g];
            cerchio_magico_data.S = [cerchio_magico_data.S; s];
            cerchio_magico_data.colormap = [cerchio_magico_data.colormap; sRGB];
        end
    end
end



if congiungenti>0
    
    n = congiungenti;
    
    range = sub_lambda(1):abs(sub_lambda(1)-sub_lambda(2))*n:sub_lambda(end);
    
    range = [range sub_lambda(end)];
    
    for j = min(sigma):0.5:max(sigma)
        for i = range
            if i>=min(sub_lambda) && i<=max(sub_lambda)
                if(j==0)
                    spettro(:,2) = 0;
                    spettro((spettro(:,1)==i),2) = 1;
                else
                    spettro(:,2) = normpdf(spettro(:,1), i, j);
                end
                
                [g, s] = spectra_to_phasor(spettro, harmonic, 0);
                
                sRGB = spectrumRGB(i);
                
                cerchio_magico_data.G = [cerchio_magico_data.G; g];
                cerchio_magico_data.S = [cerchio_magico_data.S; s];
                cerchio_magico_data.colormap = [cerchio_magico_data.colormap; sRGB];
            end
            
        end
    end
end


end

