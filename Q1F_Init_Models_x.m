clear;
clc;
%% Initialize Parameters
M = 1000;
m1 = 100;
m2 = 100;
l1 = 20;
l2 = 10;
g = 9.8;

%% Use A and Vmatrix from Q1(B)
A =[ 0, 1,               0,     0,              0, 0;
     0, 0,       -(m1*g)/M,     0,      -(m2*g)/M, 0;
     0, 0,               0,     1,              0, 0;
     0, 0,  -(M+m1)*g/M/l1,     0,   -(m2*g)/M/l1, 0;
     0, 0,               0,     0,              0, 1;
     0, 0,    -(m1*g)/M/l2,     0, -(M+m2)*g/M/l2, 0];
B =[ 0;
     1/M;
     0;
     1/(M*l1);
     0;
     1/(M*l2)];

C_all = eye(6);

D = zeros(6,1);

%% Set Values of R and Q to get K matrix using LQR()
Q=[ 10 0 0 0 0 0;
    0 600 0 0 0 0;
    0 0 50 0 0 0;
    0 0 0 700 0 0;
    0 0 0 0 50 0;
    0 0 0 0 0 150];
R=  0.004;

[K,S,e] = lqr(A,B,Q,R)
PolesL= 3*e

%% Set Initial Condition X_0 in degrees --  X_0_l is to convert X_0 in radians
X_0 = [10 0 0 0 0 0]';
X_0_l = [X_0(1) X_0(2) X_0(3)*pi/180 X_0(4)*pi/180 X_0(5)*pi/180 X_0(6)*pi/180]';


%% Observer StateSpace for States (x(t))
Cx = [1 0 0 0 0 0];
Lx_t = place(A',Cx',PolesL);
Lx=Lx_t'
Ax_obs = [A-Lx*Cx];
Bx_obs = [B Lx];
Cx_obs = Cx;
Dx_obs = [0 0; 0 0; 0 0; 0 0; 0 0; 0 0];
X_0_x_obs = [0 0 0 0 0 0];