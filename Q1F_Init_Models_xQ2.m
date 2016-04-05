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
Q=[ 5 0 0 0 0 0;
    0 60 0 0 0 0;
    0 0 50 0 0 0;
    0 0 0 70 0 0;
    0 0 0 0 150 0;
    0 0 0 0 0 100];
R=  0.0001;

[K,S,e] = lqr(A,B,Q,R)
PolesL= 4*e

%% Set Initial Condition X_0 in degrees --  X_0_l is to convert X_0 in radians
X_0 = [10 0 0 0 0 0]';
X_0_l = [X_0(1) X_0(2) X_0(3)*pi/180 X_0(4)*pi/180 X_0(5)*pi/180 X_0(6)*pi/180]';

%% Observer StateSpace for States (x(t),Q2(t))
CxQ2 = [1 0 0 0 0 0;
        0 0 0 0 1 0];
LxQ2_t = place(A',CxQ2',PolesL)
LxQ2 = LxQ2_t';
AxQ2_obs = [A-LxQ2*CxQ2];
BxQ2_obs = [B LxQ2];
CxQ2_obs = CxQ2;
DxQ2_obs = [0 0 0; 0 0 0;0 0 0;0 0 0;0 0 0; 0 0 0];
X_0_xQ2_obs = [0 0 0 0 0 0];
