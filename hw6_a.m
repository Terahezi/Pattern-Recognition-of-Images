% random initialization
mu_FG_ri=zeros(5,8,64);
mu_BG_ri=zeros(5,8,64);
for i=1:5
    mu_FG_ri(i,:,:)=[rand(8,1),zeros(8,63)];
    mu_BG_ri(i,:,:)=[rand(8,1),zeros(8,63)];
end
sigma_ri=zeros(8,64,64);
for i=1:8
    sigma_ri(i,:,:)=diag(ones(1,64));
end
pi_unnormalized_FG=rand(5,8);
pi_unnormalized_BG=rand(5,8);
pi_ri_FG=pi_unnormalized_FG./sum(pi_unnormalized_FG,2);
pi_ri_BG=pi_unnormalized_BG./sum(pi_unnormalized_BG,2);


% Starting point of iteration
load('TrainingSamplesDCT_8_new.mat')
mu_FG=mu_FG_ri;
p_FG=pi_ri_FG;
mu_BG=mu_BG_ri;
p_BG=pi_ri_BG;
sigma_FG=sigma_ri;
sigma_BG=sigma_ri;

mu_FG_mix=zeros(5,8,64);
mu_BG_mix=zeros(5,8,64);
sigma_FG_mix=zeros(5,8,64,64);
sigma_BG_mix=zeros(5,8,64,64);
p_FG_mix=zeros(5,8);
p_BG_mix=zeros(5,8);
% Iterate to get optimal parameters

for iter=1:5
    New_Q_FG=2;
    Old_Q_FG=1;
    New_Q_BG=2;
    Old_Q_BG=1;
    p_FG=pi_ri_FG(iter,:);
    mu_FG=squeeze(mu_FG_ri(iter,:,:));
    while (New_Q_FG-Old_Q_FG)/Old_Q_FG>0.001
        hw6_a_Iter_FG
    end
    mu_FG_mix(iter,:,:)=mu_FG;
    sigma_FG_mix(iter,:,:,:)=sigma_FG;
    p_FG_mix(iter,:)=p_FG;
    
    p_BG=pi_ri_BG(iter,:);
    mu_BG=squeeze(mu_BG_ri(iter,:,:));
    while (New_Q_BG-Old_Q_BG)/Old_Q_BG>0.001
        hw6_a_Iter_BG
    end
    mu_BG_mix(iter,:,:)=mu_BG;
    sigma_BG_mix(iter,:,:,:)=sigma_BG;
    p_BG_mix(iter,:)=p_BG;  
end