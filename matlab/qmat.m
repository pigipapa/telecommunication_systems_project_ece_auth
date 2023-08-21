function qi = qmat(symbols,i)

n=length(symbols);
nbits=log2(n);

switch i 
    case 1 % 1st quadrant
        if (mod(nbits,2) && nbits>3)
            %      s


            nQbits = (nbits - 1) / 2;
            mQ = 2^nQbits;
            j=0;

            for k=1:n
                if (imag(symbols(k))>=0 && imag(symbols(k))<mQ) && (real(symbols(k))>=((3*mQ/2)-1)) %square
                   j=j+1;
                   qi(j)=symbols(k);
                end    

                if real(symbols(k))>=0 && imag(symbols(k))==((3*mQ/2)-1)
                   j=j+1;
                   qi(j)=symbols(k);
                end    
            end    

            switch n 
                case 32
                    a=4+1i*(3+(2-sqrt(3)));
                    qi=[qi,a];

                case 128
                    a=[7+1i*(9+(2-sqrt(3))),8+1i*(7+(2-sqrt(3))*2),10+1i*(7+(2-sqrt(3))*2)];
                    qi=[qi,a];

                case 512 
                    a=[15+1i*(21+(2-sqrt(3))),15+1i*(17+(2-sqrt(3))*3),16+1i*(19+(2-sqrt(3))*2),16+1i*(15+(2-sqrt(3))),18+1i*(15+(2-sqrt(3))),20+1i*(15+(2-sqrt(3))),22+1i*(15+(2-sqrt(3))*4)];
                    qi=[qi,a];

                case 2048   
                    a=[31+1i*(45+(2-sqrt(3))),32+1i*(43+(2-sqrt(3))*2),31+1i*(41+(2-sqrt(3))*3),32+1i*(39+(2-sqrt(3))*4),31+1i*(37+(2-sqrt(3))*5),32+1i*(35+(2-sqrt(3))*6),31+1i*(33+(2-sqrt(3))*7),32+1i*(31+(2-sqrt(3))*8),34+1i*(31+(2-sqrt(3))*8),36+1i*(31+(2-sqrt(3))*8),38+1i*(31+(2-sqrt(3))*8),40+1i*(31+(2-sqrt(3))*8),42+1i*(31+(2-sqrt(3))*8),44+1i*(31+8*(2-sqrt(3))),46+1i*(31+(2-sqrt(3))*8)];
                    qi=[qi,a];
            end    

         %      e 
        elseif nbits==3    
            qi(:)=[0+1i, 2+1i, 4+1i];

        else
            j=0;
            sqrtM = 2^(nbits/2);
            tmp = int32(fix((n-1)/sqrtM));
            %tmp1 = 1 - sqrtM;


            for k=1:n
               if (real(symbols(k))>=tmp && imag(symbols(k))>=0) || (imag(symbols(k))==tmp && real(symbols(k))>=0)
                   j=j+1;
                   qi(j)=symbols(k);
               end
            end  


        end  
        
        
    case 2 % 2st quadrant
        if (mod(nbits,2) && nbits>3)
            %      s


            nQbits = (nbits - 1) / 2;
            mQ = 2^nQbits;
            j=0;

            for k=1:n
                if (imag(symbols(k))>=0 && imag(symbols(k))<mQ) && (real(symbols(k))<=(-(3*mQ/2)+2)) %square
                   j=j+1;
                   qi(j)=symbols(k);
                end    

                if real(symbols(k))<0 && imag(symbols(k))==((3*mQ/2)-1)
                   j=j+1;
                   qi(j)=symbols(k);
                end    
            end    

            switch n %corner symbols
                case 32
                    
                case 128
                    a=[-7+1i*(9+(2-sqrt(3))),-8+1i*(7+(2-sqrt(3))*2)];
                    qi=[qi,a];

                case 512 
                    a=[-15+1i*(21+(2-sqrt(3))),-15+1i*(17+(2-sqrt(3))*3),-16+1i*(15+(2-sqrt(3))*4),-18+1i*(15+(2-sqrt(3))*4),-20+1i*(15+(2-sqrt(3))*4),-14+1i*(19+(2-sqrt(3))*2)];
                    qi=[qi,a];

                case 2048   
                    a=[-31+1i*(45+(2-sqrt(3))),-30+1i*(43+(2-sqrt(3))*2),-31+1i*(41+(2-sqrt(3))*3),-30+1i*(39+(2-sqrt(3))*4),-31+1i*(37+(2-sqrt(3))*5),-30+1i*(35+(2-sqrt(3))*6),-31+1i*(33+(2-sqrt(3))*7),-32+1i*(31+(2-sqrt(3))*8),-34+1i*(31+(2-sqrt(3))*8),-36+1i*(31+(2-sqrt(3))*8),-38+1i*(31+(2-sqrt(3))*8),-40+1i*(31+(2-sqrt(3))*8),-42+1i*(31+(2-sqrt(3))*8),-44+1i*(31+(2-sqrt(3))*8)];
                    qi=[qi,a];
            end    

         %      e 
        elseif nbits==3    
            qi(:)=-2+1i;

        else
            j=0;
            sqrtM = 2^(nbits/2);
            tmp = int32(fix((n-1)/sqrtM));
            tmp1 = 1 - sqrtM;


            for k=1:n
               if (real(symbols(k))<=tmp1+1 && imag(symbols(k))>=0) || (imag(symbols(k))==tmp && real(symbols(k))<0)
                   j=j+1;
                   qi(j)=symbols(k);
               end
            end  


        end  
        
        
    case 3
        if (mod(nbits,2) && nbits>3)
            %      s


            nQbits = (nbits - 1) / 2;
            mQ = 2^nQbits;
            j=0;

            for k=1:n
                if (imag(symbols(k))<0 && imag(symbols(k))>=-mQ) && (real(symbols(k))<=(-(3*mQ/2)+2)) %square
                   j=j+1;
                   qi(j)=symbols(k);
                end    

                if real(symbols(k))<0 && imag(symbols(k))==-((3*mQ/2)-1)
                   j=j+1;
                   qi(j)=symbols(k);
                end    
            end    

            switch n %corner symbols
                case 32
                    a=-3+1i*(-3+4*(2-sqrt(3)));
                    qi=[qi,a];
                case 128
                    a=[-7+1i*(-7+(2-sqrt(3))),-9+1i*(-7+(2-sqrt(3))*9),-6+1i*(-9+(2-sqrt(3))*10)];
                    qi=[qi,a];

                case 512 
                    a=[-21+1i*(-15+(2-sqrt(3))*19),-19+1i*(-15+(2-sqrt(3))*19),-17+1i*(-15+(2-sqrt(3))*19),-15+1i*(-15+(2-sqrt(3))*19),-14+1i*(-17+(2-sqrt(3))*20),-15+1i*(-19+(2-sqrt(3))*21),-14+1i*(-21+(2-sqrt(3))*22)];
                    qi=[qi,a];

                case 2048   
                    a=[-45+1i*(-31+(2-sqrt(3))*39),-43+1i*(-31+(2-sqrt(3))*39),-41+1i*(-31+(2-sqrt(3))*39),-39+1i*(-31+(2-sqrt(3))*39),-37+1i*(-31+(2-sqrt(3))*39),-35+1i*(-31+(2-sqrt(3))*39),-33+1i*(-31+(2-sqrt(3))*39),-31+1i*(-31+(2-sqrt(3))*39),-30+1i*(-33+(2-sqrt(3))*40),-31+1i*(-35+(2-sqrt(3))*41),-30+1i*(-37+(2-sqrt(3))*42),-31+1i*(-39+(2-sqrt(3))*43),-30+1i*(-41+(2-sqrt(3))*44),-31+1i*(-43+(2-sqrt(3))*45),-30+1i*(-45+(2-sqrt(3))*46)];
                    qi=[qi,a];
            end    

         %      e 
        elseif nbits==3    
            qi(:)=[-3-1i,-1-1i];

        else
            j=0;
            sqrtM = 2^(nbits/2);
            tmp = int32(fix((n-1)/sqrtM));
            tmp1 = 1 - sqrtM;


            for k=1:n
               if (real(symbols(k))<=tmp1+1 && imag(symbols(k))<0) || (imag(symbols(k))==(-tmp) && real(symbols(k))<0)
                   j=j+1;
                   qi(j)=symbols(k);
               end
            end  


        end
    
    case 4
        if (mod(nbits,2) && nbits>3)
            %      s


            nQbits = (nbits - 1) / 2;
            mQ = 2^nQbits;
            j=0;

            for k=1:n
                if (imag(symbols(k))<=0 && imag(symbols(k))>=-mQ) && (real(symbols(k))>=(3*mQ/2)-1) %square
                   j=j+1;
                   qi(j)=symbols(k);
                end    

                if real(symbols(k))>=0 && imag(symbols(k))==-((3*mQ/2)-1)
                   j=j+1;
                   qi(j)=symbols(k);
                end    
            end    

            switch n %corner symbols
                case 32
                    
                case 128
                    a=[8+1i*(-9+(2-sqrt(3))*10),9+1i*(-7+(2-sqrt(3))*9)];
                    qi=[qi,a];

                case 512 
                    a=[16+1i*(-21+(2-sqrt(3))*22),15+1i*(-19+(2-sqrt(3))*21),16+1i*(-17+(2-sqrt(3))*20),17+1i*(-15+(2-sqrt(3))*19),19+1i*(-15+(2-sqrt(3))*19),21+1i*(-15+(2-sqrt(3))*19)];
                    qi=[qi,a];

                case 2048   
                    a=[32+1i*(-45+(2-sqrt(3))*46),31+1i*(-43+(2-sqrt(3))*45),32+1i*(-41+(2-sqrt(3))*44),31+1i*(-39+(2-sqrt(3))*43),32+1i*(-37+(2-sqrt(3))*42),31+1i*(-35+(2-sqrt(3))*41),32+1i*(-33+(2-sqrt(3))*40),33+1i*(-31+(2-sqrt(3))*39),35+1i*(-31+(2-sqrt(3))*39),37+1i*(-31+(2-sqrt(3))*39),39+1i*(-31+(2-sqrt(3))*39),41+1i*(-31+(2-sqrt(3))*39),43+1i*(-31+(2-sqrt(3))*39),45+1i*(-31+(2-sqrt(3))*39)];
                    qi=[qi,a];
            end    

         %      e 
        elseif nbits==3    
            qi(:)=[1-1i,3-1i];

        else
            j=0;
            sqrtM = 2^(nbits/2);
            tmp = int32(fix((n-1)/sqrtM));
            tmp1 = 1 - sqrtM;


            for k=1:n
               if (real(symbols(k))>=tmp && imag(symbols(k))<=0) || (imag(symbols(k))==(-tmp) && real(symbols(k))>=0)
                   j=j+1;
                   qi(j)=symbols(k);
               end
            end  


        end
    
end    
    
end
