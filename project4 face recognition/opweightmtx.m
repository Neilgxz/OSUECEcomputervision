%% optical flow
function [Y]=opweightmtx(test,mean)
I1=reshape(mean,[55,60]);
I2=reshape(test,[55,60]);
opticFlow = opticalFlowHS; % Horn-Schunck Optical flow
flow = estimateFlow(opticFlow,I1); %optical flow from blank to I1.
flow = estimateFlow(opticFlow,I2); %optical flow from I1 to I2.i.e. mean to the test
Z=max(max(flow.Magnitude));
Y=Z-flow.Magnitude; %inverse proportional
Y=mat2gray(Y);
Y=reshape(Y,[1,3300]);
Y=diag(Y);
end