% random initialization
load('TrainingSamplesDCT_8_new.mat')

% load image, make doubles and pad image with zeros
A=im2double(imread('cheetah.bmp'));
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
% Priors defined
Prior_cheetah=250/1303;
Prior_grass=1053/1303;

% hw6_a_BDR_PoE_dim
C=[1,2,4,8,16,32];
dimensions=[1,2,4,8,16,24,32,40,48,56,64];
PoE_all=zeros(6,11);

GroundTruth=im2double(imread('cheetah_mask.bmp'));

for iter=1:6
    
    C_iter=C(iter);
    

    mu_FG_ri=rand(C_iter,64);
    mu_BG_ri=rand(C_iter,64);

    sigma_ri=zeros(C_iter,64,64);
    for i=1:C_iter
        sigma_ri(i,:,:)=diag(ones(1,64));
    end

    % 
    pi_unnormalized_FG=rand(1,C_iter);
    pi_unnormalized_BG=rand(1,C_iter);
    pi_ri_FG=pi_unnormalized_FG./sum(pi_unnormalized_FG,2);
    pi_ri_BG=pi_unnormalized_BG./sum(pi_unnormalized_BG,2);

    % Starting point of iteration
    
    mu_FG=mu_FG_ri;
    mu_BG=mu_BG_ri;
    p_FG=pi_ri_FG;
    p_BG=pi_ri_BG;
    sigma_FG=sigma_ri;
    sigma_BG=sigma_ri;
    
    % Iterate to get optimal parameters
    New_Q_FG=2;
    Old_Q_FG=1;
    New_Q_BG=2;
    Old_Q_BG=1;
    
    while (New_Q_FG-Old_Q_FG)/Old_Q_FG>0.01
        hw6_b_Iter_FG
    end

    while (New_Q_BG-Old_Q_BG)/Old_Q_BG>0.01
        hw6_b_Iter_BG
    end
    
    StateV_Y=zeros(size(TestSampleDCT,1),11);

    hw6_b_BDR
    
end


% plot the image
figure
plot(dimensions,PoE_all)
title('PoE vs dimension for 6 mixture components')
xlabel('dimension')
ylabel('PoE')
