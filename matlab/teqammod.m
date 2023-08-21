function constellation = teqammod(M, varargin)
    % COMM.INTERNAL.QAM.GETSQUARECONSTELLATION Return an ordered square QAM
    % constellation
    %
    % CONSTELLATION = COMM.INTERNAL.QAM.GETSQUARECONSTELLATION(M) returns
    % the square QAM constellation for modulation order M.
    %
    % CONSTELLATION = COMM.INTERNAL.QAM.GETSQUARECONSTELLATION(M,
    % INI_PHASE) returns the square QAM constellation, rotated by INI_PHASE
    % (rad).
    %
    % Assumptions & Notes:
    % 1) M must be an integer power of 2
    % 2) INI_PHASE must be scalar, real, numeric value
    % 3) Support floating point constellations only. The output (constellation)
    % is of same datatype as input (M). So, for single precision
    % constellation, M must be single.
    % 4) This is an internal function which does not do any input
    % validations. It is users responsibility to ensure that the above
    % conditions are met.
    %
    %   See also COMM.INTERNAL.QAM.GETIDEALCONSTELLATION.
    
    %    Copyright 1996-2017 The MathWorks, Inc.
    
    %#codegen
    
    if(nargin == 1 || isempty(varargin{1}) )
        ini_phase = 0;
    else
        ini_phase = varargin{1};
    end
    
    nbits  = log2(M);
    constellation = coder.nullcopy(complex(zeros(1,M,'like',M),zeros(1,M,'like',M)));
    
    % Trivial case, M = 2;
    if (nbits == 1)
        realConst = [-1 1];
        constellation(:) = realConst.*exp(1i*ini_phase);
        return
    end
    
    
    dmin=2;
    
    if (mod(nbits,2) && nbits>3)
        % Cross constellation The following algorithm for the cross
        % constellation was converted to M from the C S-function scomapskmod.c
        % Compute log2(M) for bit input
        nIbits = (nbits + 1) / 2;
        nQbits = (nbits - 1) / 2;
        mI = 2^nIbits;
        mQ = 2^nQbits;
        tmp1 = fix((M-1)/mI);
        tmp2 = 3*mI/4;
        tmp3 = mI/2;
        tmp4 = mQ/2;
        tmp5 = 2*mQ;
        tmp6 = 1-mI;
        tmp7 = 1-mQ;
        
        
        
        
        
        
        for i = 0:2:(M-2)
            iData  = fix(i/mQ);
            qData = cast(bitand(int32(i), int32(tmp1)), 'like', M);
            cplxData = complex((2 * iData + tmp6), (-1 * (2 * qData + tmp7)));
            %if(M>8)
            iMag = abs(floor(real(cplxData)));
            if (iMag > tmp2)
                qMag = abs(floor(imag(cplxData)));
                iSgn = sign(real(cplxData));
                qSgn = sign(imag(cplxData));
                if(qMag > tmp4)
                    cplxData = complex(iSgn*(iMag - tmp3), ( qSgn*(tmp5 - qMag)));
                else
                    cplxData = complex(iSgn*(mI - iMag), (qSgn*(mQ + qMag)));
                end
            end
            
            %end
            if (abs(imag(cplxData))<mQ)
                constellation(i+1) =  complex(real(cplxData)+1, imag(cplxData));
            elseif imag(cplxData)>mQ
                for k=1:2:15
                    if (k==1 || k==5 || k==9 || k==13)
                        if imag(cplxData)==(2^nQbits)+k
                            constellation(i+1) =  complex(real(cplxData), imag(cplxData));
                        end
                    else
                        if imag(cplxData)==(2^nQbits)+k
                            constellation(i+1) =  complex(real(cplxData)+1, imag(cplxData));
                        end    
                    end
                end
            elseif imag(cplxData)<-mQ   
                for k=1:2:15
                    if (k==1 || k==5 || k==9 || k==13)
                        if imag(cplxData)==-(2^nQbits)-k
                            constellation(i+1) =  complex(real(cplxData)+1, imag(cplxData));
                        end
                    else
                        if imag(cplxData)==-(2^nQbits)-k
                            constellation(i+1) =  complex(real(cplxData), imag(cplxData));
                        end    
                    end
                end
            end
        end
        
        
        
        
        
        for i = 1:2:(M-1)
            iData  = fix(i/mQ);
            qData = cast(bitand(int32(i), int32(tmp1)), 'like', M);
            cplxData = complex((2 * iData + tmp6), (-1 * (2 * qData + tmp7)));
            %if(M>8)
            iMag = abs(floor(real(cplxData)));
            if (iMag > tmp2)
                qMag = abs(floor(imag(cplxData)));
                iSgn = sign(real(cplxData));
                qSgn = sign(imag(cplxData));
                if(qMag > tmp4)
                    cplxData = complex(iSgn*(iMag - tmp3), ( qSgn*(tmp5 - qMag)));
                else
                    cplxData = complex(iSgn*(mI - iMag), (qSgn*(mQ + qMag)));
                end
            end
            
            %end
            if (abs(imag(cplxData))<mQ)
                constellation(i+1) =  complex(real(cplxData), imag(cplxData));
            elseif imag(cplxData)>mQ
                for k=1:2:15
                    if (k==1 || k==5 || k==9 || k==13)
                        if imag(cplxData)==(2^nQbits)+k
                            constellation(i+1) =  complex(real(cplxData), imag(cplxData));
                        end
                    else
                        if imag(cplxData)==(2^nQbits)+k
                            constellation(i+1) =  complex(real(cplxData)+1, imag(cplxData));
                        end    
                    end
                end
            elseif imag(cplxData)<-mQ   
                for k=1:2:15
                    if (k==1 || k==5 || k==9 || k==13)
                        if imag(cplxData)==-(2^nQbits)-k
                            constellation(i+1) =  complex(real(cplxData)+1, imag(cplxData));
                        end
                    else
                        if imag(cplxData)==-(2^nQbits)-k
                            constellation(i+1) =  complex(real(cplxData), imag(cplxData));
                        end
                    end
                end    
            end
        end
          
        %move symbols to y axis 
        %in order to have equal distances between them
        for k=1:length(constellation)
            if imag(constellation(k))<((3*mQ/2)-1)
                imag1=imag(constellation(k))+(2-sqrt(3))*((3*mQ/2)-1-imag(constellation(k)))/2;
                real1=real(constellation(k));
                constellation(k)=complex(real1,imag1);
            end 
        end
                

        
    elseif nbits==3
        % M=8        
        constellation(:) = [-2+1i, -3+(1-sqrt(3))*1i, 0+1i, -1+(1-sqrt(3))*1i, 2+1i, 1+(1-sqrt(3))*1i, 4+1i, 3+(1-sqrt(3))*1i];
        
    else
        % Square QAM
        sqrtM = 2^(nbits/2);
        tmp = int32(fix((M-1)/sqrtM));
        tmp1 = 1 - sqrtM;
        for k = 0:2:M-2
            iData = fix(k/sqrtM);
            qData = cast(bitand(int32(k), tmp), 'like', M);
            constellation(k+1) = complex(2*iData + tmp1+1, -1*(2*qData + tmp1));
        end  
        
        for k = 1:2:M-1
            iData = fix(k/sqrtM);
            qData = cast(bitand(int32(k), tmp), 'like', M);
            constellation(k+1) = complex(2*iData + tmp1, -1*(2*qData + tmp1));
        end   
        
        %move symbols to y axis 
        %in order to have equal distances between them
        count=0;
        for k=1:length(constellation)
         if imag(constellation(k))~=tmp
             count=count+1;
             real2=real(constellation(k));
             imag2=imag(constellation(k));
             constellation(k)=complex(real2,imag2+count*(2-sqrt(3)));
             if count==tmp
                 count=0;
             end    
         end
        end
        
    end
    
    
    
    % rotate the constellation by the phase rotation.
    constellation(:) = constellation.*exp(1i*ini_phase);
    
end