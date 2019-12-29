u=[1;2;2];
E=[1,0,0;0,5,2;0,2,5];
X=[0.5,0,1]';
p=1/((2*pi)^(3/2)*det(E)^(1/2))*exp(-1/2*(X-u)'*inv(E)*(X-u))

% b
A=[1,0,0;0,3,0;0,0,7];
fei=[1,0,0;0,1/2^(1/2),1/2^(1/2);0,-1/2^(1/2),1/2^(1/2)];
Aw=fei*A^(-1/2)

% c
% Xw=transpose(Aw)*(X-u)
Xw=Aw'*(X-u)

% d
% calculate Mahalanobis distance in the original 
% and transformed distribution
O=(X-u)'*E^(-1)*(X-u)
T=(Xw-0)'*eye(size(E))^(-1)*(Xw-0)