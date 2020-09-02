%% Main file (run animation)
% Associate file: eom2.m, Approach_1_ODE.m, Ellipse_Animation.m, rotation.m

run Approach_1_ODE.m

clc

a = 2;
b = 1;
m = 10;
g = 9.81;
X_total = 0;
Theta = X(4,:);

dt = Theta(1,2) - Theta(1,1);
%% DO I WANT TO RECORD THE VIDEO
VIDEO = 1;

%% SETUP VIDEO IF REQUIRED
if VIDEO
    fps = 1/dt;
    MyVideo = VideoWriter('try_numerical','MPEG-4');
    MyVideo.FrameRate = fps;
    open(MyVideo);
end
handle = figure;
hold on

%% Simulation

for k=1:size(Theta,2)
   
    cla
    plot([-100 100],[0 0]); %Floor
    hold on
    if(k == 1)
        Xc(k) = 0;
        Zc(k) = 1;
        radius(k) = 1;
    else
        PSI(k) = atan2(a^2*sin(Theta(k)),b^2*cos(Theta(k)));
        radius(k) = a*b/sqrt(b^2*(sin(PSI(k)))^2+a^2*(cos(PSI(k)))^2);
        Xc(k) = radius(k)*(Theta(1,3)-Theta(1,2));
        Zc(k) = abs(radius(k)*cos(PSI(k)-Theta(k)));
        X_total = Xc(k) + X_total;
    end
    
    %Plotting ellipse (pre-rotate)
    t = linspace(0,2*pi,1000);
    x=a*cos(t);
    y=b*sin(t);
    
    %Rotation matrix
    R1to0 = [cos(Theta(k)) sin(Theta(k));-sin(Theta(k)) cos(Theta(k))];
    
    [x1_rotated,y1_rotated] = rotation(x,y,R1to0);    %Use rotation function to obtain the rotated coordinates of the ellipse 
    
    %Plot the ellipse with new centers
    X_vector = zeros(1,size(Theta,2));
    X_vector(1,:) = Xc(1,k) + X_total;
    
    Z_vector = zeros(1,size(y1_rotated,2));
    Z_vector(1,:) = Zc(k);
    
    x_new = x1_rotated(1,:) + X_vector(1,k);
    y_new = y1_rotated(1,:) + Z_vector(1,:);
    plot(x_new,y_new)

    axis square
    axis([0 40 -20 20])
    xlabel('X')
    ylabel('Y')
    
    if VIDEO
         writeVideo(MyVideo,getframe(handle));
     else
         pause(dt)
     end
end


if VIDEO
    fprintf('Done recording.\n');
    close(MyVideo)
end