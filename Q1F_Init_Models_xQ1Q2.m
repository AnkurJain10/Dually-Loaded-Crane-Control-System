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
Q=[ 1 0 0 0 0 0;
    0 60 0 0 0 0;
    0 0 1500 0 0 0;
    0 0 0 500 0 0;
    0 0 0 0 500 0;
    0 0 0 0 0 500];
R=  0.0001;

[K,S,e] = lqr(A,B,Q,R)
PolesL= 5*e

%% Set Initial Condition X_0 in degrees --  X_0_l is to convert X_0 in radians
X_0 = [10 0 0 0 0 0]';
X_0_l = [X_0(1) X_0(2) X_0(3)*pi/180 X_0(4)*pi/180 X_0(5)*pi/180 X_0(6)*pi/180]';

%% Observer StateSpace for States (x(t),Q1(t),Q2(t))
CxQ1Q2 = [1 0 0 0 0 0;
          0 0 1 0 0 0;
          0 0 0 0 1 0];
LxQ1Q2_t = place(A',CxQ1Q2',PolesL)
LxQ1Q2 = LxQ1Q2_t';
AxQ1Q2_obs = [A-LxQ1Q2*CxQ1Q2];
BxQ1Q2_obs = [B LxQ1Q2];
CxQ1Q2_obs = CxQ1Q2;
DxQ1Q2_obs = [0 0 0 0; 0 0 0 0;0 0 0 0;0 0 0 0;0 0 0 0;0 0 0 0];
X_0_xQ1Q2_obs = [0 0 0 0 0 0];