%% ODE Solver
% Associate file: eom2.m, Approach_1_ODE.m, Ellipse_Animation.m, rotation.m
echo eom2 on

clear all
close all
clc

a = 2;
b = 1;
m = 10;
g = 9.81;

%% SETUP THE PROBLEM
% x z r th si dx dz dr dth dsi
x_init = [0;1;1;0;0;0;1;0;1;1.5];    % initial conditions obtained from constraint.m

tspan = [0 3];                                   % start and finish times
x_dot = @(t,x) eom2(t,x);

options = odeset('RelTol',1e-2,'AbsTol',1e-2');   % solver options
sol = ode23tb(x_dot,tspan,x_init, options);          % SOLVE the eoms (Stiff ODE)

%% EVAULATE THE SOLUTION
dt = 0.1;                                         % set time step                        
t = tspan(1):dt:tspan(2);                         % creat time vector
X = deval(sol,t)                                 % Evaluate the solutions

