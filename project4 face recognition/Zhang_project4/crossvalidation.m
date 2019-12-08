clear all
close all
%% change k to decide the test times.
k=10;
testnumber=ceil(rand(k,100)*26);
accuracy=zeros(1,k);
%% training set
for l=1:k
    img_path = '../down_sampled_AR/';
    img_dir = dir([img_path '*.bmp']);
    img_num = length(img_dir);
    training=zeros(2600,19800);
    for i = 1:100
        for j= 1:26
            if j~=testnumber(l,i)
                img_name = img_dir(((i-1)*26)+j).name;
                tmp = imread(strcat(img_path, img_name));
                tmp = double(rgb2gray(tmp));
                training(((i-1)*26)+j,:)=reshape(tmp,1,19800);
            end
        end
    end
    training(all(training==0,2),:) = [];
    u=mean(training);
    P=training-u;
    [U,S,M] = svds(P,100);
    trainingp=training*M;
    %% mean face for each identity
    meanface=zeros(100,100);
    for i=1:25:2500
        meanface(ceil(i/25),:)= mean(trainingp(i:i+24,:));
    end
    %% covariance for each identity
    sigmap=zeros(100,100,100);
    for i=1:100
        j=(i-1)*25;
        t=trainingp(j+1:j+25,:)-meanface(i,:);
        sigmap(:,:,i)=t'*t+0.001.*eye(100);
    end
    %% test set
    for i=1:100
        img_name = img_dir((i-1)*26+testnumber(l,i)).name;
        tmp = imread(strcat(img_path, img_name));
        tmp = double(rgb2gray(tmp));
        test(i,:)=reshape(tmp,1,19800);
    end
    testp=test*M;
    %% Cross-validation
    distance=zeros(1,100);
    class=zeros(1,100);
    for i=1:100
        for j=1:100
            distance(j)=(testp(i,:)-meanface(j,:))/sigmap(:,:,j)*(testp(i,:)-meanface(j,:))';
        end
        [SB,identity] = min(distance);
        class(i)=identity;
    end
    for i=1:100
        if class(i)==i
            accuracy(l)=accuracy(l)+1;
        end
    end
end
%% get the result
accuracy= accuracy/100;
meanaccuracy=mean(accuracy);
medianaccuracy=median(accuracy);