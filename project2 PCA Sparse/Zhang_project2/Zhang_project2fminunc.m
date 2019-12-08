clear all
close all
p=8; % window size
for i=40:48
             b=imread(['..\Natural_Scenes\','sharp',num2str(i),'.jpg']);
             b=rgb2gray(b);
             a(:,:,i-39)=b;
end
image=a(1:8,1:8,1);
img=reshape(image',[1,64]);
img=double(img);
img=img.*1./sqrt(sum(img.^2)); 
img(isnan(img))=0;
optbasis=rand(100,64)-0.5;
optA=zeros(1,100);
save optbasis.mat optbasis;
save img.mat img; 
options=optimset('MaxIter',1);
%% optimization
[optA,Eval]=fminunc(@E,optA,options);
save optA.mat optA;
[optbasis,Eval]=fminunc(@B,optbasis,options);
save optbasis.mat optbasis;
figure;
for i= 1:size(optbasis,1)
    f(:,:,i) = reshape(optbasis(i,:),[8,8]) ;
    subplot(10,10,i);
    imshow(f(:,:,i)',[]);
end

