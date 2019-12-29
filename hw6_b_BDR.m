
for dim=1:11

    dim_used=dimensions(dim);
    % BDR
    G_cheetah=zeros(size(TestSampleDCT,1),1);
    G_grass=zeros(size(TestSampleDCT,1),1);
   
    for i=1:68850
                
        x=TestSampleDCT(i,1:dim_used);
        SS1=0;
        SS2=0;
        for com=1:C_iter     
            SS1=SS1+posterior_z(mu_FG(com,1:dim_used),squeeze(sigma_FG(com,1:dim_used,1:dim_used)),p_FG(com),x,dim_used)*Prior_cheetah;
            G_cheetah(i)=SS1;
            SS2=SS2+posterior_z(mu_BG(com,1:dim_used),squeeze(sigma_BG(com,1:dim_used,1:dim_used)),p_BG(com),x,dim_used)*Prior_grass;
            G_grass(i)=SS2;
        end
                
        if G_cheetah(i)<G_grass(i)
            StateV_Y(i,dim)=0;
            
        elseif G_cheetah(i)>G_grass(i)
            StateV_Y(i,dim)=1;
        end
    end
     % get PoE
    hw6_b_PoE
    PoE_all(iter,dim)=PoE;
end
PoE_all(iter,:)

function y=posterior_z(mu,sigma,p,x,dim)
y=1/(2*pi)^(dim/2)/det(sigma)^(1/2)*exp(-1/2*(x-mu)*sigma^(-1)*(x-mu)')*p;
end