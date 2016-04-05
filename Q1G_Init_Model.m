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
B =[  0;
      1/M;
        0;
 1/(M*l1);
        0;
 1/(M*l2)];

C_all = eye(6);
       
D = zeros(6,1);

%% Set Initial Condition X_0 in degrees --  X_0_l is to convert X_0 in radians
X_0 = [1 0 0 0 0 0]';
X_0_l = [X_0(1) X_0(2) X_0(3)*pi/180 X_0(4)*pi/180 X_0(5)*pi/180 X_0(6)*pi/180]';

%% LQG Kalman
Cx = [1 0 0 0 0 0];
Linear_System = ss(A,B,Cx,0);
Qk = (diag([0.1 0 0 0 0 0; 0 500*100 0 0 0 0; 0 0 700*1000 0 0 0; 0 0 0 700*1000 0 0; 0 0 0 0 1000*1000 0; 0 0 0 0 0 1000*1000]))';
Rk = 5;
%% LQG
Qe = [Qk Rk] ;
Qe = diag(Qe);
Re = [1 0.1 0.1 0.1 1 0.1 0.1];
Re =diag(Re);
klqg=lqg(Linear_System,Qe,Re)