% get h_ij
h_ij_FG=zeros(250,C_iter);
for i=1:250
    for j=1:C_iter
        h_ij_FG(i,j)=posterior_z(mu_FG(j,:),squeeze(sigma_FG(j,:,:)),p_FG(j),TrainsampleDCT_FG(i,:));
    end
end
NC_FG=sum(h_ij_FG,2);

h_ij_FG=h_ij_FG./NC_FG;

% Start to iterate to renew parameters
mu_FG_Iter=h_ij_FG'*TrainsampleDCT_FG./sum(h_ij_FG)';
sigma_FG_Iter=zeros(C_iter,64,64);
for j=1:C_iter
    S=0;
    T=0;
    for i=1:250
        S=S+h_ij_FG(i,j)*(TrainsampleDCT_FG(i,:)-mu_FG_Iter(j,:))'*(TrainsampleDCT_FG(i,:)-mu_FG_Iter(j,:));
        T=T+h_ij_FG(i,j);
    end
    sigma_FG_Iter(j,:,:)=diag(diag(S/T)+0.001);
end

pi_FG_Iter=sum(h_ij_FG)./250;

% Compute old Q function
log_posterior=zeros(250,C_iter);
for i=1:250
    for j=1:C_iter
        log_posterior(i,j)=posterior_z(mu_FG(j,:),squeeze(sigma_FG(j,:,:)),p_FG(j),TrainsampleDCT_FG(i,:));
    end
end
Old_Q_FG=sum(sum(h_ij_FG'*log_posterior));
% Renew parameters
mu_FG=mu_FG_Iter;
p_FG=pi_FG_Iter;
sigma_FG=sigma_FG_Iter;
% Compute new Q function
log_posterior=zeros(250,C_iter);
for i=1:250
    for j=1:C_iter
        log_posterior(i,j)=posterior_z(mu_FG(j,:),squeeze(sigma_FG(j,:,:)),p_FG(j),TrainsampleDCT_FG(i,:));
    end
end
New_Q_FG=sum(sum(h_ij_FG'*log_posterior));

% def functions

function y=posterior_z(mu,sigma,p,x)
y=1/(2*pi)^(64/2)/det(sigma)^(1/2)*exp(-1/2*(x-mu)*sigma^(-1)*(x-mu)')*p;
end