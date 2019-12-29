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
% calculate the state variable Y using BDR
%featureX_BG=zeros(size(TestSampleDCT,1),1);
%featureX_FG=zeros(size(TestSampleDCT,1),1);
%StateV_Y=zeros(size(TestSampleDCT,1),1);
% ConP_FG=1/(2*pi)^(d/2)/(rank(E_cheetah))^(1/2)*exp(-1/2*(x-u_cheetah)*E_cheetah^(-1)*(x-u_cheetah)');
% ConP_BG=1/(2*pi)^(d/2)/(rank(E_grass))^(1/2)*exp(-1/2*(x-u_grass)*E_grass^(-1)*(x-u_grass)');
% classify using 64-dimensional Gaussian
% for i =1:68850
%    x=TestSampleDCT(i,:);
%    featureX_FG(i)=1/(2*pi)^(d/2)/(det(E_cheetah))^(1/2)*exp(-1/2*(x-u_cheetah)*E_cheetah^(-1)*(x-u_cheetah)');
%    featureX_BG(i)=1/(2*pi)^(d/2)/(det(E_grass))^(1/2)*exp(-1/2*(x-u_grass)*E_grass^(-1)*(x-u_grass)');
%    if Prior_cheetah * featureX_FG(i)<Prior_grass * featureX_BG(i)
%        StateV_Y(i)=0;
%    else if Prior_cheetah * featureX_FG(i)>Prior_grass * featureX_BG(i)
%        StateV_Y(i)=1;
%        end
%    end
%end
% classify using log form of BDR
G_cheetah=zeros(size(TestSampleDCT,1),1);
G_grass=zeros(size(TestSampleDCT,1),1);
StateV_Y=zeros(size(TestSampleDCT,1),1);
for i=1:68850
    x=TestSampleDCT(i,:);
    G_cheetah(i)=(x-u_cheetah)*E_cheetah^(-1)*(x-u_cheetah)'+d*log(2*pi)+log(det(E_cheetah))-2*log(Prior_cheetah);
    G_grass(i)=(x-u_grass)*E_grass^(-1)*(x-u_grass)'+d*log(2*pi)+log(det(E_grass))-2*log(Prior_grass);
    if G_cheetah(i)<G_grass(i)
        StateV_Y(i)=1;
    else if G_cheetah(i)>G_grass(i)
        StateV_Y(i)=0;
        end
    end
end
% output state variable Y and plot the image
StateV_Y;
figure
imagesc((reshape(StateV_Y,270,255)).')
colormap(gray(255))

function y=posterior_z(mu,sigma,p,x)
y=1/(2*pi)^(64/2)*det(sigma)^(1/2)*exp(-1/2*(x-mu)*sigma^(-1)*(x-mu)')*p;
end