function [meanface,sigmap,M]=meansigmaM(I)
%% face space
u = mean(I);
P = I-u;
[U,S,M] = svds(P,100);
Ip=I*M;
%% mean face for each identity
meanface=zeros(100,100);
for i=1:13:1300
        meanface(ceil(i/13),:)= mean(Ip(i:i+12,:));
end
%% covariance for each identity
sigmap=zeros(100,100,100);
for i=1:100
    j=(i-1)*13;
    t=Ip(j+1:j+12,:)-meanface(i,:);
    sigmap(:,:,i)=t'*t+0.001.*eye(100);
end
