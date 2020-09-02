%% Setting up equation of motion (generalized coordinates: x, z, r, theta, psi)

clear all

%% Initialized the system

syms x z r th si t a b m g

X = sym('x(t)');
Z = sym('z(t)');
TH = sym('th(t)');
PSI = sym('si(t)');
R = sym('r(si)');
    
%% Setting up equation (refer to the report for details)

OC_r = [X + R*sin(PSI-TH); 0; Z-R*cos(PSI-TH)];         % Vector OC_r from ellipse's center of gravity to point of contact C
dot_OC_r = diff(OC_r,t)+diff(OC_r,si);                  % Finding OC_r dot
dot_dot_OC_r = diff(dot_OC_r,t) + diff(dot_OC_r,si);    % Finding OC_r dot dot

radius = a*b/sqrt(b^2*(sin(PSI))^2+a^2*(cos(PSI))^2);   % Radius of ellipse in terms of polar angle, PSI
dot_radius = diff(radius,t)+diff(radius,si);            % Finding R dot
dot_dot_radius = diff(dot_radius,t)+diff(dot_radius,si);% Finding R dot dot

PSI = atan(-a^2/b^2*tan(TH));                           % Polar angle PSI in terms of rotation angle theta (refer to report) (CHANGED)
dot_PSI = diff(PSI,t)+diff(PSI,si);                     % Finding PSI dot
dot_dot_PSI = diff(dot_PSI,t)+diff(dot_PSI);            % Findign PSI dot dot

%% Setting up Lagrangian

syms dx dz dr dth dsi ddx ddz ddr ddth ddsi

L = 1/2*(m*dx^2 + m*dz^2 + m*(a^2+b^2)/4*dth^2) - m*g*z;    % Lagrangian (refer to the report group 23)

d_L_dx = diff(L,x)          % Derivative of L with respect to x 
d_L_dz = diff(L,z)          % Derivative of L with respect to z    
d_L_dr = diff(L,r)          % Derivative of L with respect to r
d_L_dth = diff(L,th)        % Derivative of L with respect to theta
d_L_dsi = diff(L,si)        % Derivative of L with respect to si

d_L_ddx = diff(L,dx)        % Derivative of L with respect to dx
d_L_ddz = diff(L,dz)        % Derivative of L with respect to dz
d_L_ddr = diff(L,dr)        % Derivative of L with respect to dr
d_L_ddth = diff(L,dth)      % Derivative of L with respect to dth
d_L_ddsi = diff(L,dsi)      % Derivative of L with respect to dsi

%% Using the results from above we get the left hand side of the EoM to be

L_eq1 = m*ddx - d_L_dx == 0     
L_eq2 = m*ddz - d_L_dz == 0
L_eq3 = 0 - d_L_dr == 0
L_eq4 = (ddth*m*(a^2 + b^2))/4 - d_L_dth == 0
L_eq5 = 0 - d_L_dsi == 0
