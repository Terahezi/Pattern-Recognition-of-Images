% get h_ij

h_ij_BG=zeros(1053,8);

for i=1:1053
    for j=1:8
        h_ij_BG(i,j)=posterior_z(mu_BG(j,:),squeeze(sigma_BG(j,:,:)),p_BG(j),TrainsampleDCT_BG(i,:));
    end
end

NC_BG=sum(h_ij_BG,2);

h_ij_BG=h_ij_BG./NC_BG;
% Start to iterate to renew parameters
mu_BG_Iter=h_ij_BG'*TrainsampleDCT_BG./sum(h_ij_BG)';
sigma_BG_Iter=zeros(8,64,64);
for j=1:8
    S=0;
    T=0;
    for i=1:1053
        S=S+h_ij_BG(i,j)*(TrainsampleDCT_BG(i,:)-mu_BG_Iter(j,:))'*(TrainsampleDCT_BG(i,:)-mu_BG_Iter(j,:));
        T=T+h_ij_BG(i,j);
    end
    sigma_BG_Iter(j,:,:)=diag(diag(S/T)+0.001);
end
     
pi_BG_Iter=sum(h_ij_BG)./1053;
% Compute old Q function
log_posterior=zeros(1053,8);
for i=1:1053
    for j=1:8
        log_posterior(i,j)=posterior_z(mu_BG(j,:),squeeze(sigma_BG(j,:,:)),p_BG(j),TrainsampleDCT_BG(i,:));
    end
end
Old_Q_BG=sum(sum(h_ij_BG'*log_posterior));
% Renew parameters
mu_BG=mu_BG_Iter;
p_BG=pi_BG_Iter;
sigma_BG=sigma_BG_Iter;
% Compute new Q function
log_posterior=zeros(1053,8);
for i=1:1053
    for j=1:8
        log_posterior(i,j)=posterior_z(mu_BG(j,:),squeeze(sigma_BG(j,:,:)),p_BG(j),TrainsampleDCT_BG(i,:));
    end
end
New_Q_BG=sum(sum(h_ij_BG'*log_posterior));

% def functions

function y=posterior_z(mu,sigma,p,x)
y=1/(2*pi)^(64/2)/det(sigma)^(1/2)*exp(-1/2*(x-mu)*sigma^(-1)*(x-mu)')*p;
end