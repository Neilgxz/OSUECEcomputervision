clear all
close all
%% training set and test set
img_path = '../down_sampled_AR/';
img_dir = dir([img_path '*.bmp']);
img_num = length(img_dir);
training=zeros(2600,19800);
test=zeros(2600,19800);
for i = 1:img_num
    if rem(ceil(i/13),2)==0
        img_name = img_dir(i).name;
        tmp = imread(strcat(img_path, img_name));
        tmp = double(rgb2gray(tmp));
        test(i,:)=reshape(tmp,1,19800);
    end
    if rem(ceil(i/13),2)~=0
        img_name = img_dir(i).name;
        tmp = imread(strcat(img_path, img_name));
        tmp = double(rgb2gray(tmp));
        training(i,:)=reshape(tmp,1,19800);
    end
end
training(all(training==0,2),:) = [];
test(all(test==0,2),:) = [];
%% SVDs
u=mean(training);
P=training-u;
[U,S,M] = svds(P,100);
trainingp=training*M;
testp=test*M;
%% mean face for each identity
meanface=zeros(100,100);
for i=1:13:1300
    meanface(ceil(i/13),:)= mean(trainingp(i:i+12,:));
end
%% covariance for each identity
sigmap=zeros(100,100,100);
for i=1:100
    j=(i-1)*13;
    t=trainingp(j+1:j+12,:)-meanface(i,:);
    sigmap(:,:,i)=t'*t+0.001.*eye(100);
end
%% Duplicates
distance=zeros(1,100);
class=zeros(1,1300);
for i=1:1300
    for j=1:100
        distance(j)=(testp(i,:)-meanface(j,:))/sigmap(:,:,j)*(testp(i,:)-meanface(j,:))';
    end
    [SB,identity] = min(distance);
    class(i)=identity;
end
accuracy=0;
for i=1:1300
    if class(i)==ceil(i/13)
        accuracy=accuracy+1;
    end
end
accuracy= accuracy/1300;
