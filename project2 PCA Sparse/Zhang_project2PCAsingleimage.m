clear all
close all
a= imread('Natural_Scenes\sharp5.jpg'); 
b= size(a);
%% Get the matrix x of windows' features
p=8;    %window size
x=zeros(b(1)/p*b(2)/p*b(3),p*p); 
c= size(x);
% the number of windows is x(1) and each window has p*p features(pixels)
for k= 1:b(3)
    for i = 1:b(1)
         for j = 1:b(2)
                x(  ((ceil(i/p)-1)*256/p+ceil(j/p))+(k-1)*c(1)/3  ,  rem(i-1,p)*p+(rem(j-1,p)+1)  ) = a(i,j,k);
         end
    end
end
%% PCA
u = mean(x);      
P = x-u;         
Q = P'*P; % Q is a symmetric positive semi definite matrix called convariance matrix
[V,D] = eig(Q);
V=fliplr(V); 
for i= 1:p*p
    f(:,:,i) = reshape(V(:,i),[p,p]) ;
    subplot(p,p,i);
    imshow(f(:,:,i),[]);
end
%% Reconstruct image
% select principle component
q=0.05; %rate
for i= 1:ceil(p*p*q)
    v(:,i)=V(:,i);
end
% The matrix P*v is the result of the reducing dimensions
% If we want to reconstruct the image back the size of x (b(1)/p*b(2)/p*b(3),p*p), 
% we should multiple v'. And plus the mean u.
% v*v' is called projection matrix, if we select all p*p eigenvectors v*v'=I. 
% We also know, as a matrix of eigenvector, v'*v=I because the 2-norm of v
% equals to 1. And every two eigenvectors are orthgonal.
h = (P*v*v')+u; 
for k= 1:b(3)
    for i = 1:c(1)
         for j = 1:p*p
               l((ceil((rem(i-1,1024)+1)/32)-1)*8+ceil(j/8), rem(rem(i-1,1024),32)*8+rem(j-1,8)+1, ceil(i/1024) ) = h(i,j);
         end
    end
end
l =uint8(l);
figure, imshow(l);