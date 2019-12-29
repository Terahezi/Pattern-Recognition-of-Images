% B-BDR

% Compute covariance of the class conditional
FG_cov_cc;
BG_cov_cc;
% datasets to be used
D_FG;
D_BG;
% Compute the posterior mean and covariance of Pu|T
al;
mu0_FG;
mu0_BG;
cov0=diag(al*W0);
N_sample_FG=size(D_FG,1);
N_sample_BG=size(D_BG,1);
sample_mean_FG=mean(D_FG,1);
sample_mean_BG=mean(D_BG,1);
mu1_FG=cov0*(cov0+1/N_sample_FG*FG_cov_cc)^(-1)*sample_mean_FG'+1/N_sample_FG*FG_cov_cc*(cov0+1/N_sample_FG*FG_cov_cc)^(-1)*mu0_FG';
mu1_BG=cov0*(cov0+1/N_sample_BG*BG_cov_cc)^(-1)*sample_mean_BG'+1/N_sample_BG*BG_cov_cc*(cov0+1/N_sample_BG*BG_cov_cc)^(-1)*mu0_BG';
sigma1_FG=cov0*(cov0+1/N_sample_FG*FG_cov_cc)^(-1)*1/N_sample_FG*FG_cov_cc;
sigma1_BG=cov0*(cov0+1/N_sample_BG*BG_cov_cc)^(-1)*1/N_sample_BG*BG_cov_cc;
% Compute the prameters of predictive distribution
muPD_FG=mu1_FG;
muPD_BG=mu1_BG;
sigmaPD_FG=FG_cov_cc+sigma1_FG;
sigmaPD_BG=BG_cov_cc+sigma1_BG;
% ML estimates of priors
prior_FG=N_sample_FG/(N_sample_FG+N_sample_BG);
prior_BG=N_sample_BG/(N_sample_FG+N_sample_BG);

% define dimensinality of sample
d=64;
% load image, make doubles and pad image with zeros
A=im2double(imread('cheetah.bmp'));
% B=padarray(A,[7,7],0,'post');
B=padarray(A(:,1:end-1),[7,8],'replicate','post');
% B=padarray(A(:,1:end-1),[7,8],'replicate','post');
% B(:,end-7)=0;
% Find index vector I for zigzag pattern
O=dlmread('Zig-Zag Pattern.txt');
[a,I]=sort(O(:));
% Select blocks consisting of 8x8 pixels
% Use sliding window to get frequency coefficient for each block
[m,n]=size(A);
TestSampleDCT=zeros(m*n,64);
% use for loops to select blocks of 8x8 pixels, apply dct2 to get
% frequency coefficients and transform to horizontal vectors
% following zigzag pattern 
k=1;
for i = 1:m
    for j=1:n
        C=dct2(B(i:i+7,j:j+7));
        TestSampleDCT(k,:)=C(I);
        k=k+1;
    end
end
TestSampleDCT;
% Classification using BDR
G_cheetah=zeros(size(TestSampleDCT,1),1);
G_grass=zeros(size(TestSampleDCT,1),1);
StateV_Y=zeros(size(TestSampleDCT,1),1);
for i=1:68850
    x=TestSampleDCT(i,:);
    G_cheetah(i)=(x-muPD_FG')*sigmaPD_FG^(-1)*(x-muPD_FG')'+d*log(2*pi)+log(det(sigmaPD_FG))-2*log(prior_FG);
    G_grass(i)=(x-muPD_BG')*sigmaPD_BG^(-1)*(x-muPD_BG')'+d*log(2*pi)+log(det(sigmaPD_BG))-2*log(prior_BG);
    if G_cheetah(i)<=G_grass(i)
        StateV_Y(i)=1;
    else if G_cheetah(i)>G_grass(i)
        StateV_Y(i)=0;
        end
    end
end
% output state variable Y and plot the image
StateV_Y;
% figure
% imagesc((reshape(StateV_Y,270,255)).')
% colormap(gray(255))
% Calculate probability of error
GroundTruth=im2double(imread('cheetah_mask.bmp'));
Mask=(reshape(StateV_Y,270,255)).';
N_FG_Pixels=0;
N_BG_Pixels=0;
FG_misc=0;
BG_misc=0;
for i=1:255
    for j=1:270
       if GroundTruth(i,j)==1
           N_FG_Pixels = N_FG_Pixels+1;
           if Mask(i,j)==0
               FG_misc=FG_misc+1;
           end
       elseif GroundTruth(i,j)==0
           N_BG_Pixels=N_BG_Pixels+1;
           if Mask(i,j)==1
               BG_misc=BG_misc+1;
           end
       end
    end
end
p_FG_error=FG_misc/N_FG_Pixels*prior_FG;
% p_FG_error1=FG_misc/(N_FG_Pixels+N_BG_Pixels);
p_BG_error=BG_misc/N_BG_Pixels*prior_BG;
% p_BG_error1=BG_misc/(N_FG_Pixels+N_BG_Pixels);
PoE=p_FG_error+p_BG_error
