%% KSVD
function [dic]=KSVD(data,dictionary,G)
for i= 1:size(dictionary,2)
    index= find(G(i,:)~=0); 
    while (index)
    e=data;
    m = [1:i-1 i+1:size(dictionary,2)];
    e=e-dictionary(:,m)*G(m,:); 
    ek=e(:,index);
    [U,S,V] = svd(ek);
    dictionary(:,i)=U(:,1);
    G(i,index)=S(1,1)*V(:,1);
    index=0;
    end
end
dic=dictionary;
end