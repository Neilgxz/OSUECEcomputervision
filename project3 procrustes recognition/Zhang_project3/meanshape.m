%% mean_shapenew
function [mean_shape]=meanshape(A,preshapeall)
    for j=1:8
        shape_sum=zeros(100,100);
        for i=1:10
            if i~=A(j)
                t=preshapeall(:,(i+(j-1)*10));
                temp=t*conj(t)';
                shape_sum=shape_sum+temp;
            end
        end
        [V,D]=eigs(shape_sum);
        mean_shape(:,j)=V(:,1);
%         figure,
%         scatter(real(mean_shape(:,j)),imag(mean_shape(:,j)),'k*');
    end
end