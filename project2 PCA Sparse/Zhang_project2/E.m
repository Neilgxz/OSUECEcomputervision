function [Eval]=E(optA)
 load('img.mat');
 load('optbasis.mat');
 Eval=sum((minus(img,optA*optbasis)).^2)+sum(abs(optA))*0.14;
end