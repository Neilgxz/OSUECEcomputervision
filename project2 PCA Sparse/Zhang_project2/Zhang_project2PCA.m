clear all
close all
p=8; % window size
for i=40:48
             b=imread(['..\Natural_Scenes\','sharp',num2str(i),'.jpg']);
             b=rgb2gray(b);
             a(:,:,i-39)=b;
end
c=size(a);
c= floor (c/p);
x=zeros(c(2)*c(1)*9,p*p);
% the number of windows is x(1) and each window has p*p features(pixels)
for i=1:9
    for j=1:c(1)
         for k=1:c(2)
                l=(j-1)*p;
                t=(k-1)*p;
                x(  (i-1)*c(2)*c(1) + rem(j-1,c(1))*c(1) + rem(k-1,c(2))+1 ,:)=[ reshape(  (a(l+1:l+p,t+1:t+p,i))' ,[1,p*p] )];
         end
    end
end
%% PCA
u = mean(x);      
P = x-u;         
Q = P'*P; 
[V,D] = eig(Q);
V=fliplr(V); 
figure;
for i= 1:8*8
    f(:,:,i) = reshape(V(:,i),[p,p]) ;
    subplot(8,8,i);
    imshow(f(:,:,i),[]);
end