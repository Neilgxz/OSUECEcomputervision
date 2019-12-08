clear all
close all
%% recognition
% get all preshape landmark: preshapeall
categorization = ["car","apple","pear","dog","horse","cow","tomato","cup"];
preshapeall=[];
for j=1:14
    if j~=4&&j~=8&&j~=10&&j~=13
        path=strcat('../eth80-cropped256/');    
        path=strcat(path,categorization(1));
        path=strcat(path,int2str(j));
        path=strcat(path,'/maps/');
        path=strcat(path,categorization(1));
        path=strcat(path,int2str(j));
        path=strcat(path,'-066-153-map.png');
        shape=preshape(path);
        preshapeall=[preshapeall,shape];
    end
end
for i=2:8
    for j=1:10
        path=strcat('../eth80-cropped256/');    
        path=strcat(path,categorization(i));
        path=strcat(path,int2str(j));
        path=strcat(path,'/maps/');
        path=strcat(path,categorization(i));
        path=strcat(path,int2str(j));
        path=strcat(path,'-066-153-map.png');
        shape=preshape(path);
        preshapeall=[preshapeall,shape];
    end
end
% select test sample and get meanshape of others : mean_shape
% compare Df
result=[];
times=1;
for k=1:times
    A= ceil(10*rand(8,1));
    [mean_shape]=meanshape(A,preshapeall);
    for i=1:8
        for j=1:8
        x=[real(preshapeall(:,(A(i)+(i-1)*10))),imag(preshapeall(:,(A(i)+(i-1)*10)))] ;
        y=[real(mean_shape(:,j)),imag(mean_shape(:,j))];
        t=y'*x;
        [U,S,V] = svd(t);
        num=S(1,1)+S(2,2);
        df(j)=(1-num^2)^(0.5);
        end
        [~,pos(i)]=min(df);
    end
        result(k,:)=pos;
end
correct=zeros(times,1);
for i=1:times
    for j=1:8       
        if result(i,j)==j
            correct(i)=correct(i)+1;
        end
    end
end
correct=correct/8;
u=mean(correct);
v=std(correct);