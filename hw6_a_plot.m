% define parameters
d=64;

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

dimensions=[1,2,4,8,16,24,32,40,48,56,64];
PoE_all=zeros(25,11);

GroundTruth=im2double(imread('cheetah_mask.bmp'));

for dim=1:11
    iter=0;
    PoE=zeros(25,1);
    dim_used=dimensions(dim);
    % BDR
    G_cheetah=zeros(size(TestSampleDCT,1),5);
    G_grass=zeros(size(TestSampleDCT,1),5);
    StateV_Y=zeros(size(TestSampleDCT,1),25);
    
    for i_FG=1:5
        for i_BG=1:5
            iter=iter+1;
            for i=1:68850
                
                x=TestSampleDCT(i,1:dim_used);
                SS1=0;
                SS2=0;
                for com=1:8
                    
                    SS1=SS1+posterior_z(squeeze(mu_FG_mix(i_FG,com,1:dim_used))',squeeze(sigma_FG_mix(i_FG,com,1:dim_used,1:dim_used)),p_FG_mix(i_FG,com),x,dim_used)*Prior_cheetah;
                    G_cheetah(i,i_FG)=SS1;
                    SS2=SS2+posterior_z(squeeze(mu_BG_mix(i_BG,com,1:dim_used))',squeeze(sigma_BG_mix(i_BG,com,1:dim_used,1:dim_used)),p_BG_mix(i_BG,com),x,dim_used)*Prior_grass;
                    G_grass(i,i_BG)=SS2;
                end
                
                if G_cheetah(i,i_FG)<G_grass(i,i_BG)
                    StateV_Y(i,iter)=0;
                elseif G_cheetah(i,i_FG)>G_grass(i,i_BG)
                    StateV_Y(i,iter)=1;
        
                end
            end
            hw6_a_PoE
        end
    end
    % get PoE
    
    
    PoE_all(:,dim)=PoE
    
    
end
% plot the image
figure
plot(dimensions,PoE_all)
title('PoE vs dimension for 25 classifiers')
xlabel('dimension')
ylabel('PoE')

function y=posterior_z(mu,sigma,p,x,dim)
y=1/(2*pi)^(dim/2)/det(sigma)^(1/2)*exp(-1/2*(x-mu)*sigma^(-1)*(x-mu)')*p;
end