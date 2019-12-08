%% OMP Orthogonal Matching Pursuit
function [A, res]=OMP(data, dictionary, L)
A=zeros(size(dictionary,2),size(data,2));
res=zeros(1, size(data,2));
 for j=1:size(data,2)
    residual=data(:,j); 
    indx=zeros(L,1);
    a=zeros(size(dictionary,2),1);
     for i=1:L
         proj=dictionary'*residual;
         [~,pos]=max(abs(proj));
         pos=pos(1);
         indx(i)=pos;
         p=dictionary(:,indx(1:i));
         f=p*inv(p'*p)*p';
%        a= pinv(p)*data(:,j); 
%        a= pinv(p'*p)*p'*data(:,j);
%        residual=data(:,j)-p*a;
         a(indx(indx~=0),1)=a(indx(indx~=0),1)+pinv(p)*f*residual; 
         residual=residual-f*residual;
         res(j)=sum(residual.^2);
         if res(j)<1e-6
             break;
         end
     end
     A(:,j)=a;
%    A(indx(indx~=0),j)=a;
 end
end