% get the plots of PoE vs alpha
load('Alpha.mat')
load('TrainingSamplesDCT_subsets_8.mat')

% Strategy 1 & Dataset 1
% get a list of PoE values for B-BDR
load('Prior_1.mat')
D_FG=D1_FG;
D_BG=D1_BG;
FG_cov_cc=cov(D1_FG);
BG_cov_cc=cov(D1_BG);
Val_PoE_B=zeros(1,9);

for ij = 1:9
    al=alpha(ij);
    hw3_a;
    Val_PoE_B(ij)=PoE;
end

% get a list of PoE values for ML-BDR
Val_PoE_ML=ones(1,9);
hw3_b;
Val_PoE_ML=Val_PoE_ML*PoE;

% get a list of PoE values for B-MAP-BDR
Val_PoE_B_MAP=zeros(1,9);

for ij = 1:9
    al=alpha(ij);
    hw3_c;
    Val_PoE_B_MAP(ij)=PoE;
end

% plot val_PoE vs alpha
x=alpha;
y1=Val_PoE_B;
y2=Val_PoE_ML;
y3=Val_PoE_B_MAP;
figure
semilogx(x,y1)
title('S1 & D1')
xlabel('log of alpha')
ylabel('PoE')

hold on
semilogx(x,y2)

hold on
semilogx(x,y3)

legend('B-BDR','ML-BDR','B-MAP-BDR')


% Strategy 1 & Dataset 2
% get a list of PoE values for B-BDR
D_FG=D2_FG;
D_BG=D2_BG;
FG_cov_cc=cov(D2_FG);
BG_cov_cc=cov(D2_BG);
Val_PoE_B=zeros(1,9);

for ij = 1:9
    al=alpha(ij);
    hw3_a;
    Val_PoE_B(ij)=PoE;
end

% get a list of PoE values for ML-BDR
Val_PoE_ML=ones(1,9);
hw3_b;
Val_PoE_ML=Val_PoE_ML*PoE;

% get a list of PoE values for B-MAP-BDR
Val_PoE_B_MAP=zeros(1,9);

for ij = 1:9
    al=alpha(ij);
    hw3_c;
    Val_PoE_B_MAP(ij)=PoE;
end

% plot val_PoE vs alpha
x=alpha;
y1=Val_PoE_B;
y2=Val_PoE_ML;
y3=Val_PoE_B_MAP;
figure
semilogx(x,y1)
title('S1 & D2')
xlabel('log of alpha')
ylabel('PoE')

hold on
semilogx(x,y2)

hold on
semilogx(x,y3)

legend('B-BDR','ML-BDR','B-MAP-BDR')


% Strategy 1 & Dataset 3
% get a list of PoE values for B-BDR
D_FG=D3_FG;
D_BG=D3_BG;
FG_cov_cc=cov(D3_FG);
BG_cov_cc=cov(D3_BG);
Val_PoE_B=zeros(1,9);

for ij = 1:9
    al=alpha(ij);
    hw3_a;
    Val_PoE_B(ij)=PoE;
end

% get a list of PoE values for ML-BDR
Val_PoE_ML=ones(1,9);
hw3_b;
Val_PoE_ML=Val_PoE_ML*PoE;

% get a list of PoE values for B-MAP-BDR
Val_PoE_B_MAP=zeros(1,9);

for ij = 1:9
    al=alpha(ij);
    hw3_c;
    Val_PoE_B_MAP(ij)=PoE;
end

% plot val_PoE vs alpha
x=alpha;
y1=Val_PoE_B;
y2=Val_PoE_ML;
y3=Val_PoE_B_MAP;
figure
semilogx(x,y1)
title('S1 & D3')
xlabel('log of alpha')
ylabel('PoE')

hold on
semilogx(x,y2)

hold on
semilogx(x,y3)

legend('B-BDR','ML-BDR','B-MAP-BDR')


% Strategy 1 & Dataset 4
% get a list of PoE values for B-BDR
D_FG=D4_FG;
D_BG=D4_BG;
FG_cov_cc=cov(D4_FG);
BG_cov_cc=cov(D4_BG);
Val_PoE_B=zeros(1,9);

for ij = 1:9
    al=alpha(ij);
    hw3_a;
    Val_PoE_B(ij)=PoE;
end

% get a list of PoE values for ML-BDR
Val_PoE_ML=ones(1,9);
hw3_b;
Val_PoE_ML=Val_PoE_ML*PoE;

% get a list of PoE values for B-MAP-BDR
Val_PoE_B_MAP=zeros(1,9);

for ij = 1:9
    al=alpha(ij);
    hw3_c;
    Val_PoE_B_MAP(ij)=PoE;
end

% plot val_PoE vs alpha
x=alpha;
y1=Val_PoE_B;
y2=Val_PoE_ML;
y3=Val_PoE_B_MAP;
figure
semilogx(x,y1)
title('S1 & D4')
xlabel('log of alpha')
ylabel('PoE')

hold on
semilogx(x,y2)

hold on
semilogx(x,y3)

legend('B-BDR','ML-BDR','B-MAP-BDR')

% Strategy 2 & Dataset 1
% get a list of PoE values for B-BDR
load('Prior_2.mat')
D_FG=D1_FG;
D_BG=D1_BG;
FG_cov_cc=cov(D1_FG);
BG_cov_cc=cov(D1_BG);
Val_PoE_B=zeros(1,9);

for ij = 1:9
    al=alpha(ij);
    hw3_a;
    Val_PoE_B(ij)=PoE;
end

% get a list of PoE values for ML-BDR
Val_PoE_ML=ones(1,9);
hw3_b;
Val_PoE_ML=Val_PoE_ML*PoE;

% get a list of PoE values for B-MAP-BDR
Val_PoE_B_MAP=zeros(1,9);

for ij = 1:9
    al=alpha(ij);
    hw3_c;
    Val_PoE_B_MAP(ij)=PoE;
end

% plot val_PoE vs alpha
x=alpha;
y1=Val_PoE_B;
y2=Val_PoE_ML;
y3=Val_PoE_B_MAP;
figure
semilogx(x,y1)
title('S2 & D1')
xlabel('log of alpha')
ylabel('PoE')

hold on
semilogx(x,y2)

hold on
semilogx(x,y3)

legend('B-BDR','ML-BDR','B-MAP-BDR')


% Strategy 2 & Dataset 2
% get a list of PoE values for B-BDR
D_FG=D2_FG;
D_BG=D2_BG;
FG_cov_cc=cov(D2_FG);
BG_cov_cc=cov(D2_BG);
Val_PoE_B=zeros(1,9);

for ij = 1:9
    al=alpha(ij);
    hw3_a;
    Val_PoE_B(ij)=PoE;
end

% get a list of PoE values for ML-BDR
Val_PoE_ML=ones(1,9);
hw3_b;
Val_PoE_ML=Val_PoE_ML*PoE;

% get a list of PoE values for B-MAP-BDR
Val_PoE_B_MAP=zeros(1,9);

for ij = 1:9
    al=alpha(ij);
    hw3_c;
    Val_PoE_B_MAP(ij)=PoE;
end

% plot val_PoE vs alpha
x=alpha;
y1=Val_PoE_B;
y2=Val_PoE_ML;
y3=Val_PoE_B_MAP;
figure
semilogx(x,y1)
title('S2 & D2')
xlabel('log of alpha')
ylabel('PoE')

hold on
semilogx(x,y2)

hold on
semilogx(x,y3)

legend('B-BDR','ML-BDR','B-MAP-BDR')

% Strategy 2 & Dataset 3
% get a list of PoE values for B-BDR
D_FG=D3_FG;
D_BG=D3_BG;
FG_cov_cc=cov(D3_FG);
BG_cov_cc=cov(D3_BG);
Val_PoE_B=zeros(1,9);

for ij = 1:9
    al=alpha(ij);
    hw3_a;
    Val_PoE_B(ij)=PoE;
end

% get a list of PoE values for ML-BDR
Val_PoE_ML=ones(1,9);
hw3_b;
Val_PoE_ML=Val_PoE_ML*PoE;

% get a list of PoE values for B-MAP-BDR
Val_PoE_B_MAP=zeros(1,9);

for ij = 1:9
    al=alpha(ij);
    hw3_c;
    Val_PoE_B_MAP(ij)=PoE;
end

% plot val_PoE vs alpha
x=alpha;
y1=Val_PoE_B;
y2=Val_PoE_ML;
y3=Val_PoE_B_MAP;
figure
semilogx(x,y1)
title('S2 & D3')
xlabel('log of alpha')
ylabel('PoE')

hold on
semilogx(x,y2)

hold on
semilogx(x,y3)

legend('B-BDR','ML-BDR','B-MAP-BDR')


% Strategy 2 & Dataset 4
% get a list of PoE values for B-BDR
D_FG=D4_FG;
D_BG=D4_BG;
FG_cov_cc=cov(D4_FG);
BG_cov_cc=cov(D4_BG);
Val_PoE_B=zeros(1,9);

for ij = 1:9
    al=alpha(ij);
    hw3_a;
    Val_PoE_B(ij)=PoE;
end

% get a list of PoE values for ML-BDR
Val_PoE_ML=ones(1,9);
hw3_b;
Val_PoE_ML=Val_PoE_ML*PoE;

% get a list of PoE values for B-MAP-BDR
Val_PoE_B_MAP=zeros(1,9);

for ij = 1:9
    al=alpha(ij);
    hw3_c;
    Val_PoE_B_MAP(ij)=PoE;
end

% plot val_PoE vs alpha
x=alpha;
y1=Val_PoE_B;
y2=Val_PoE_ML;
y3=Val_PoE_B_MAP;
figure
semilogx(x,y1)
title('S2 & D4')
xlabel('log of alpha')
ylabel('PoE')

hold on
semilogx(x,y2)

hold on
semilogx(x,y3)

legend('B-BDR','ML-BDR','B-MAP-BDR')