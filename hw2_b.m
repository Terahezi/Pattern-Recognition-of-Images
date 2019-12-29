% Compute the maximum likelihood estimates for the parameters
% of the class conditional densities
load('TrainingSamplesDCT_8_new.mat')
% cheetah class
u_cheetah=mean(TrainsampleDCT_FG);
E_cheetah=cov(TrainsampleDCT_FG);
% grass class
u_grass=mean(TrainsampleDCT_BG);
E_grass=cov(TrainsampleDCT_BG);
% compute the marginal desities for the 64 features
MD_cheetah=zeros(1,64);
figure
j=1;
for i=1:64
    
    % subplot for cheetah class
    subplot(8,8,j)
    x1=linspace(min(TrainsampleDCT_FG(:,i)),max(TrainsampleDCT_FG(:,i)));
    y1=1/sqrt(2*pi)/E_cheetah(i,i)^(1/2)*exp(-(x1-u_cheetah(i)).^2/2/E_cheetah(i,i));
    
    plot(x1,y1)
    % subplot for grass class
    hold on
    subplot(8,8,j)
    x2=linspace(min(TrainsampleDCT_BG(:,i)),max(TrainsampleDCT_BG(:,i)));
    y2=1/sqrt(2*pi)/E_grass(i,i)^(1/2)*exp(-(x2-u_grass(i)).^2/2/E_grass(i,i));
    
    plot(x2,y2,'r')
    
    j=j+1;
end
