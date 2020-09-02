%Filename: Approach_1_solving_generalized_coordinates.m
%% Solving the EoM and EoC for all the double dot terms
clear all

syms x dx ddx z dz ddz r dr ddr th dth ddth si dsi ddsi t a b m g

%% The coefficient from the equation of contraints in Pffafian form
a11 = 1;
a12 = sin(si-th);
a13 = r*cos(si-th);
a14 = -r*cos(si-th);
a15 = 0;
a21 = 0;
a22 = -cos(si-th);
a23 = -r*sin(si-th);
a24 = r*sin(si-th);
a25 = 1;
a31 = 0;
a32 = 2*(b^2*(sin(si))^2+a^2*(cos(si))^2)^(3/2);
a33 = -a*b*(sin(2*si))*(a^2-b^2);
a34 = 0;
a35 = 0;
a41 = 0;
a42 = 0;
a43 = a^4*(tan(th))^2/b^2+b^2;
a44 = a^2*((tan(th))^2+1);
a45 = 0;

%% Setting up the EoM and EoC
syms l1 l2 l3 l4

% EoM from the Lagrangian
eq1 = m*ddx - l1*a11 - l2*a21 - l3*a31 - l4*a41;                %Checked
eq2 = m*ddz + m*g - l1*a15 - l2*a25 - l3*a35 - l4*a45;          %Checked
eq3 = ddth*m*(a^2+b^2)/4 - l1*a14 - l2*a24 - l3*a34 - l4*a44;   %Checked
eq4 = -l1*a12 - l2*a22 - l3*a32 - l4*a42;                       %Checked
eq5 = -l1*a13 - l2*a23 - l3*a33 - l4*a43;                       %Checked

% EoC from the constraints (Velocity forms differentiated)
eq6 = sin(si-th)*ddr + ddx + 2*cos(si-th)*(dsi-dth)*dr + r*cos(si-th)*(ddsi-ddth) - sin(si-th)*r*(dsi - dth)^2;
eq7 = ddz - cos(si-th)*ddr + 2*sin(si-th)*(dsi-dth)*dr + sin(si-th)*r*(ddsi-ddth) + r*cos(si-th)*(dsi-dth)^2;
eq8 = ddr - (3*a*b*(2*cos(si)*sin(si)*dsi*a^2 - 2*cos(si)*sin(si)*dsi*b^2)^2)/(4*(a^2*cos(si)^2 + b^2*sin(si)^2)^(5/2)) + (a*b*(2*a^2*cos(si)^2*dsi^2 - 2*b^2*cos(si)^2*dsi^2 - 2*a^2*sin(si)^2*dsi^2 + 2*b^2*sin(si)^2*dsi^2 + 2*a^2*cos(si)*sin(si)*ddsi - 2*b^2*cos(si)*sin(si)*ddsi))/(2*(a^2*cos(si)^2 + b^2*sin(si)^2)^(3/2));
eq9 = ddsi - ((4*a^6*tan(th)*(tan(th)^2 + 1)^2*dth^2)/(b^6*((a^4*tan(th)^2)/b^4 + 1)^2) - (2*a^2*(tan(th)^2 + 1)*ddth)/(b^2*((a^4*tan(th)^2)/b^4 + 1)) - (4*a^2*tan(th)*(tan(th)^2 + 1)*dth^2)/(b^2*((a^4*tan(th)^2)/b^4 + 1)));

% Solving for Lambdas (in terms of the generalized coordinates and their
% derivatives)
[l1_sol,l2_sol,l3_sol,l4_sol] = solve([eq1==0,eq2==0,eq3==0,eq5==0],[l1,l2,l3,l4]);

% Substitute the Lamdas back into the last EoM 
eq4_new = subs(eq4,[l1,l2,l3,l4],[l1_sol,l2_sol,l3_sol, l4_sol]);

% Using the last EoM with another 4 EoC and solve for the double dots (then
% set up the state space with the results)
[ddx_sol,ddz_sol,ddr_sol,ddth_sol,ddsi_sol] = solve([eq4_new==0,eq6==0,eq7==0,eq8==0,eq9==0],[ddx,ddz,ddr,ddth,ddsi]);

syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10
ddx_ss = subs(ddx_sol,[x,z,r,th,si,dx,dz,dr,dth,dsi],[x1,x2,x3,x4,x5,x6,x7,x8,x9,x10]);
ddz_ss = subs(ddz_sol,[x,z,r,th,si,dx,dz,dr,dth,dsi],[x1,x2,x3,x4,x5,x6,x7,x8,x9,x10]);
ddr_ss = subs(ddr_sol,[x,z,r,th,si,dx,dz,dr,dth,dsi],[x1,x2,x3,x4,x5,x6,x7,x8,x9,x10]);
ddth_ss = subs(ddth_sol,[x,z,r,th,si,dx,dz,dr,dth,dsi],[x1,x2,x3,x4,x5,x6,x7,x8,x9,x10]);
ddsi_ss = subs(ddsi_sol,[x,z,r,th,si,dx,dz,dr,dth,dsi],[x1,x2,x3,x4,x5,x6,x7,x8,x9,x10]);

%% Writing outputs to text file
diary ('ssVariable_plus.txt');
ddx_ss
ddz_ss
ddr_ss
ddth_ss
ddsi_ss
'End of File'
diary off
