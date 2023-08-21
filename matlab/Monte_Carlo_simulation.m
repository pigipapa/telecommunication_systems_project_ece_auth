hold on
grid on
xlabel('Es/No')
ylabel('Symbol Error probability')
%for j=4:11
    sep=[];
    %number of symblos
        n = 16;
        %modulation of H-qam
        symbols = teqammod(n);

        %genarate random symbols
        len = length(symbols);
        samples = 10^5;
        ranSig = randi([0 len-1], samples, 1);

        %QAM modulation
        modSig = genqammod(ranSig, symbols);
        
    for k=0:1:40
        

        %add awgn
        sigpower = pow2db(mean(abs(symbols).^2));
        snr = k;
        finalSig = awgn(modSig, snr, sigpower);

        %display results
        %h = scatterplot(finalSig);
        %hold on
        %scatterplot(symbols,[],[],'r*',h)
        %grid
        %hold off

        countFalse = 0;
        loop = samples;
        for i = 1:loop
           x = finalSig(i);
           nearSym = mld_detection(x, symbols);
           if nearSym ~= modSig(i)
               countFalse = countFalse + 1;
           end
        end

        sep(k+1) = vpa(countFalse / loop);
    end
    
    esno_db=0:1:40;
    esno=10.^(esno_db./10);
    plot(esno_db,sep,'-*')
    
    esno_db=0:1:40;
    esno=10.^(esno_db./10);
    sep=0.6875*exp(-esno*0.1422)+0.625*qfunc(0.5374*sqrt(esno));
    semilogy(esno_db,sep)
    
    esno_db=0:1:40;
    esno=10.^(esno_db./10);
    pa=(33/8)*qfunc(sqrt((8/35)*esno))+(2/3)*(27/8)*qfunc(sqrt(2*(8/35)*esno/3)).^2-2*(27/8)*qfunc(sqrt((8/35)*esno)).*qfunc(sqrt((8/35)*esno/3));
    semilogy(esno_db,pa)
    
    
legend('16-HQAM (sim.)','32-HQAM (sim.)', '64-HQAM (sim.)', '128-HQAM (sim.)', '256-HQAM (sim.)', '512-HQAM (sim.)', '1024-HQAM (sim.)', 'M-HQAM(approx.)', 'M-HQAM([8] approx.)') 
%end

