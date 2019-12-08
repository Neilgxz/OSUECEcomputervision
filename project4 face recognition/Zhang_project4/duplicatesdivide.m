clear all
close all
%% training set and test set
img_path = '../down_sampled_AR/';
img_dir = dir([img_path '*.bmp']);
img_num = length(img_dir);
test1=zeros(2600,3300);
test2=zeros(2600,3300);
test3=zeros(2600,3300);
test4=zeros(2600,3300);
test5=zeros(2600,3300);
test6=zeros(2600,3300);
I1=zeros(2600,3300);
I2=zeros(2600,3300);
I3=zeros(2600,3300);
I4=zeros(2600,3300);
I5=zeros(2600,3300);
I6=zeros(2600,3300);
for i = 1:img_num
    if rem(ceil(i/13),2)==0
        img_name = img_dir(i).name;
        tmp = imread(strcat(img_path, img_name));
        tmp = double(rgb2gray(tmp));
        test1(i,:)=reshape(tmp(1:55,1:60),1,3300);
        test2(i,:)=reshape(tmp(56:110,1:60),1,3300);
        test3(i,:)=reshape(tmp(111:165,1:60),1,3300);
        test4(i,:)=reshape(tmp(1:55,61:120),1,3300);
        test5(i,:)=reshape(tmp(56:110,61:120),1,3300);
        test6(i,:)=reshape(tmp(111:165,61:120),1,3300);
    end
    if rem(ceil(i/13),2)~=0
        img_name = img_dir(i).name;
        tmp = imread(strcat(img_path, img_name));
        tmp = double(rgb2gray(tmp));
        I1(i,:)=reshape(tmp(1:55,1:60),1,3300);
        I2(i,:)=reshape(tmp(56:110,1:60),1,3300);
        I3(i,:)=reshape(tmp(111:165,1:60),1,3300);
        I4(i,:)=reshape(tmp(1:55,61:120),1,3300);
        I5(i,:)=reshape(tmp(56:110,61:120),1,3300);
        I6(i,:)=reshape(tmp(111:165,61:120),1,3300);   
    end
end
I1(all(I1==0,2),:) = [];
I2(all(I2==0,2),:) = [];
I3(all(I3==0,2),:) = [];
I4(all(I4==0,2),:) = [];
I5(all(I5==0,2),:) = [];
I6(all(I6==0,2),:) = [];
test1(all(test1==0,2),:) = [];
test2(all(test2==0,2),:) = [];
test3(all(test3==0,2),:) = [];
test4(all(test4==0,2),:) = [];
test5(all(test5==0,2),:) = [];
test6(all(test6==0,2),:) = [];
[meanface1,sigmap1,M1]=meansigmaM(I1);
[meanface2,sigmap2,M2]=meansigmaM(I2);
[meanface3,sigmap3,M3]=meansigmaM(I3);
[meanface4,sigmap4,M4]=meansigmaM(I4);
[meanface5,sigmap5,M5]=meansigmaM(I5);
[meanface6,sigmap6,M6]=meansigmaM(I6);
%% duplicates
accuracy=0;
identity=zeros(6,1300);
for i=1:1300
    [identity(1,i)]=recognition( test1(i,:)  ,M1,meanface1,sigmap1);
    [identity(2,i)]=recognition( test2(i,:)  ,M2,meanface2,sigmap2);
    [identity(3,i)]=recognition( test3(i,:)  ,M3,meanface3,sigmap3);
    [identity(4,i)]=recognition( test4(i,:)  ,M4,meanface4,sigmap4);
    [identity(5,i)]=recognition( test5(i,:)  ,M5,meanface5,sigmap5);
    [identity(6,i)]=recognition( test6(i,:)  ,M6,meanface6,sigmap6);
end
class= mode(identity);
for i=1:1300
    if  class(i)==ceil(i/13)
        accuracy=accuracy+1;
    end
end
accuracy= accuracy/1300;