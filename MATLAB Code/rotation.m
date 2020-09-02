%% Rotation
% Input: Initial coordinates, rotation matrix
% Output: Rotated coordinates

function [xf,yf,zf]=rotation(xi,yi,R)

%Get number of rows and column and assigned them to I and J respectively
I=size(xi,1);
J=size(xi,2);

%Initialize the rotated coordinate matrix to be equal to the intial input
%size
xf=zeros(I,J);
yf=zeros(I,J);
%zf=zeros(I,J);

%Assign each component of the output using the input rotation matrix
for ii=1:I
    for jj=1:J
        vector=[xi(ii,jj);yi(ii,jj)];
        vector=R*vector;
            xf(ii,jj)=vector(1);
            yf(ii,jj)=vector(2);
            %zf(ii,jj)=vector(3);
    end
end