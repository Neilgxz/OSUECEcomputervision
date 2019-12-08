function [Eval]=B(optbasis)
 load('img.mat');
 load('optA.mat');
 Eval=sum((minus(img,optA*optbasis)).^2)+sum(abs(optA))*0.14;
end