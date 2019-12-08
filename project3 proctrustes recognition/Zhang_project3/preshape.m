%% preshape
function [marks]= preshape(path)
    A = getmarks(path);
    marks = A(:,1)+1i*A(:,2);
    H=zeros(99,100);
    for k=1:99
         for j=1:k
             H(k,j)=-(k*(k+1))^(-0.5);
         end
         H(k,k+1)=k*(k*(k+1))^-(0.5);
    end
    marks=H'*H*marks;
    marks=marks/norm(marks);
%     scatter(real(marks),imag(marks),'k*');
%     hold on
end