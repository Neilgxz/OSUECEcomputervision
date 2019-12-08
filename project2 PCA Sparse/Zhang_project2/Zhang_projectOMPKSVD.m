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
%% Sparse
y=x(1:10,:)';
y=y*diag(1./sqrt(sum(y.^2))); 
y(isnan(y)) = 0;
r = randperm(size(x,1),81);
for i= 1:size(r,2)
    dic(:,i)=x(r(i),:)';
end
dic=dic*diag(1./sqrt(sum(dic.^2))); 
l=15;%sparse ratio
for i=1:30
    [A, res]=OMP(y,dic,l);
     resa=sum(res);
    if resa<1e-6
        break
    end
    [dic]=KSVD(y,dic,A);
end
figure;
for i= 1:size(dic,2)
    f(:,:,i) = reshape(dic(:,i),[p,p]) ;
    subplot(9,9,i);
    imshow(f(:,:,i)',[]);
end