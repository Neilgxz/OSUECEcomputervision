clear all
close all
a= imread('Natural_Scenes\sharp5.jpg'); 
b= size(a);
%% Get the matrix x of windows' features
p=8;    %window size
q=0.001; %rate
for i=1:b(1)/p
    for j=1:b(2)/p
        k=(i-1)*8;
        t=(j-1)*8;
        c(i,j)= mat2cell(a(k+1:k+8,t+1:t+8,1),[p],[p]);
        d(i,j)= mat2cell(a(k+1:k+8,t+1:t+8,2),[p],[p]);
        e(i,j)= mat2cell(a(k+1:k+8,t+1:t+8,3),[p],[p]);
    end
end
x=zeros(b(2)/p*b(1)/p,p*p*b(3));
for i = 1:b(1)/p
    for j = 1:b(2)/p
        x(rem(i-1,b(1)/p)*b(1)/p+(rem(j-1,b(2)/p)+1),:)=[(reshape((cell2mat(c(i,j)))',[1,64])) (reshape((cell2mat(d(i,j)))',[1,64])) (reshape((cell2mat(e(i,j)))',[1,64]))];
    end
end
%% PCA
u = mean(x);      
P = x-u;         
Q = P'*P; 
[V,D] = eig(Q);
V=fliplr(V); 
for i= 1:p*p*b(3)
    f = reshape(V(:,i),[p,p,b(3)]) ;
    subplot(8  ,  24   ,i);
    imshow(mat2gray(f));
end
%% Reconstruct image
for i= 1:ceil(p*p*3*q)
    v(:,i)=V(:,i);
end
h = (P*v*v')+u; 
for i=1:1024
        g( ceil(i/32) ,rem(i-1,32)+1)=mat2cell(    ( reshape(h(i,1:p*p),[p,p])          )' ,[8],[8] );
        l( ceil(i/32) ,rem(i-1,32)+1)=mat2cell(    ( reshape(h(i,p*p+1:p*p*2),[p,p])    )' ,[8],[8] );
        m( ceil(i/32) ,rem(i-1,32)+1)=mat2cell(    ( reshape(h(i,p*p*2+1:p*p*3)',[p,p]) )' ,[8],[8] );  
end
n(:,:,1)=cell2mat(g);
n(:,:,2)=cell2mat(l);
n(:,:,3)=cell2mat(m);
N =uint8(n);
figure, imshow(N);