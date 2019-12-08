%% compute distance 
function [identity]=recognition(test,M,meanface,sigmap)
testp=test*M;
distance=zeros(1,100);
for j=1:100
    distance(j)=(testp-meanface(j,:))/sigmap(:,:,j)*(testp-meanface(j,:))';
end
[SB,identity] = min(distance);
end