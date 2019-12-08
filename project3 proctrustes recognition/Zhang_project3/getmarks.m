%% getLandmarks
function [marks]= getmarks(path)
A = rgb2gray(imread(path));
R=edge(A,'canny');
points=[];
%% get all contour points clockwise
while size(points,1)<100
    [row,col] = find(R);
    x= row(1);
	y= col(1);
    points=[];
    points=[points;[x,y]];
 while isempty(getnextpoint(R,x,y))==0
    [nextpoints]=getnextpoint(R,x,y);
    points=[points;[nextpoints(1),nextpoints(2)]];
    for i=-1:1
        R(x+i,y-1)=0;
        R(x+i,y)  =0;
        R(x+i,y+1)=0;
    end
    x=nextpoints(1);
    y=nextpoints(2);
 end
end
%% select 100 pesudo-landmarks
d1=floor(size(points,1)/100);
d2=d1+1;
d3=floor((size(points,1)-d1*100)/10);
marks=[];
index=0;
for i=1:10
    for j=1:10-d3
        index=index+d1;
        marks=[marks;points(index,:)];
    end
    for j=1:d3
        index=index+d2;
        marks=[marks;points(index,:)];
    end
end
%% nextpoints function
function [nextpoints]=getnextpoint(R,x,y)
nextpoints=[];
if R(x,y-1)==1
   nextpoints=[x,y-1];
end
if R(x+1,y)==1
   nextpoints=[x+1,y];
end
if R(x,y+1)==1
   nextpoints=[x,y+1];
end
if R(x-1,y)==1
   nextpoints=[x-1,y];
end

if R(x-1,y-1)==1
   nextpoints=[x-1,y-1];
end
if R(x+1,y-1)==1
   nextpoints=[x+1,y-1];
end
if R(x+1,y+1)==1
   nextpoints=[x+1,y+1];
end
if R(x-1,y+1)==1
   nextpoints=[x-1,y+1];
end

end    
end