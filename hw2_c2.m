% classify using the 8-dimensional Gaussian with the best 8 features
d=8;
% load image, make doubles and pad image with zeros
A=im2double(imread('cheetah.bmp'));

B=padarray(A(:,1:end-1),[7,8],'replicate','post');
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
% load Train data
load('TrainingSamplesDCT_8_new.mat')
% Priors defined
Prior_cheetah=250/1303;
Prior_grass=1053/1303;
% Select the best 8 features for calculating mean, cov and TestSampleDCT
index =[1 17 18 19 21 32 33 40];
% cheetah class
u_cheetah=mean(TrainsampleDCT_FG(:,index));
E_cheetah=cov(TrainsampleDCT_FG(:,index));
% grass class
u_grass=mean(TrainsampleDCT_BG(:,index));
E_grass=cov(TrainsampleDCT_BG(:,index));
% TestSampleDCT
TestSampleDCT=TestSampleDCT(:,index);
% classify using the 8-dimensional Gaussian with the best 8 features
featureX_BG=zeros(size(TestSampleDCT,1),1);
featureX_FG=zeros(size(TestSampleDCT,1),1);
StateV_Y=zeros(size(TestSampleDCT,1),1);
for i =1:68850
    x=TestSampleDCT(i,:);
    featureX_FG(i)=1/(2*pi)^(d/2)/(det(E_cheetah))^(1/2)*exp(-1/2*(x-u_cheetah)*E_cheetah^(-1)*(x-u_cheetah)');
    featureX_BG(i)=1/(2*pi)^(d/2)/(det(E_grass))^(1/2)*exp(-1/2*(x-u_grass)*E_grass^(-1)*(x-u_grass)');
    if Prior_cheetah * featureX_FG(i)<=Prior_grass * featureX_BG(i)
        StateV_Y(i)=0;
    else if Prior_cheetah * featureX_FG(i)>Prior_grass * featureX_BG(i)
        StateV_Y(i)=1;
        end
    end
end
% output state variable Y and plot the image
StateV_Y;
figure
imagesc((reshape(StateV_Y,270,255)).')
colormap(gray(255))