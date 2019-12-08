clear all
close all
fv=[0.25,0.18,0.13,0.09,0.06];
theta=[0,pi/8,pi/4,3*pi/8,pi/2,5*pi/8,3*pi/4,7*pi/8];
phi=0;
a=1;
b=1;
[X,Y] = meshgrid(-50:50,-50:50); 
for i=1:8
    for j=1:5;
    Xprime = X .*cos(theta(i)) - Y .*sin(theta(i));
    Yprime = X .*sin(theta(i)) + Y .*cos(theta(i));
    hGaussian(:,:,(j-1)*8+i) = exp( -1/2*fv(j)*fv(j)*( Xprime.^2 ./a^2  + Yprime.^2 ./b^2));
    hGaborEven(:,:,(j-1)*8+i)  =fv(j)*fv(j)/pi/a/b*hGaussian(:,:,(j-1)*8+i) .*cos(2*pi*fv(j).*Xprime+phi);
    hGaborOdd(:,:,(j-1)*8+i)   =fv(j)*fv(j)/pi/a/b*hGaussian(:,:,(j-1)*8+i) .*sin(2*pi*fv(j).*Xprime+phi);
    h(:,:,(j-1)*8+i)  = complex(hGaborEven(:,:,(j-1)*8+i) ,hGaborOdd(:,:,(j-1)*8+i));
    end
end
for i=1:40  

    subplot(5,8,i);
    imshow(h(:,:,i),[]);
end
