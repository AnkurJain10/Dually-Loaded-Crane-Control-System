M = 1000;
m1 = 100;
m2 = 100;
l1 = 20;
l2 = 10;
g = 9.8;
A =[ 0, 1,                  0, 0,                      0, 0;
     0, 0,          -(m1*g)/M, 0,              -(m2*g)/M, 0;
     0, 0,                  0, 1,                      0, 0;
     0, 0, -(M+m1)*g/M/l1, 0,         -(m2*g)/M/l1, 0;
     0, 0,                  0, 0,                      0, 1;
     0, 0,     -(m1*g)/M/l2, 0, - (M+m2)*g/M/l2, 0];
B =[  0;
      1/M;
        0;
 1/(M*l1);
        0;
 1/(M*l2)];

C = eye(6);
D = zeros(6,1);
R = 0.1 ;
Q = [ 1   0   0   0   0   0;
      0   100   0   0   0  0;
      0   0  100*l1  0   0   0;
      0   0   0  100*l1^2  0   0;
      0   0   0   0  100*l2  0;
      0   0   0   0   0  100*l2^2];
  
[K,S,e] = lqr(A,B,Q,R)
%K = 1.0e+04 *[0.1000 1.0705 2.9820 1.4220 3.1175 -0.8110];
X_0 = [0 0 10 0 0 0]';
X_0_l = [0 0 X_0(3)*pi/180 X_0(4)*pi/180 X_0(5)*pi/180 X_0(6)*pi/180]';
X_r = [5 0 0 0 0 0]';
S_M = [B A*B A^2*B A^3*B A^4*B A^5*B];
rank(S_M);
Ac = A - B*K;
Q = eye(6);
P = lyap(Ac,Q)
eig(P)
%All eigen value of P are positive and hence X is positive definite.
disp('Observability :: x(t)')
C_st = [1 0 0 0 0 0];
C_M = [C_st; C_st*A; C_st*A^2; C_st*A^3; C_st*A^4; C_st*A^5]
rank(C_M)

disp('Observability :: Q1(t) Q2(t)')
C_st = [0 0 1 0 0 0; 0 0 0 0 1 0 ];
C_M = [C_st; C_st*A; C_st*A^2; C_st*A^3; C_st*A^4; C_st*A^5]
rank(C_M)

disp('Observability :: x(t) Q2(t)')
C_st = [1 0 0 0 0 0; 0 0 0 0 1 0];
C_M = [C_st; C_st*A; C_st*A^2; C_st*A^3; C_st*A^4; C_st*A^5]
rank(C_M)

disp('Observability :: x(t) Q1(t) Q2(t)')
C_st = [1 0 0 0 0 0; 0 0 1 0 0 0; 0 0 0 0 1 0];
C_M = [C_st; C_st*A; C_st*A^2; C_st*A^3; C_st*A^4; C_st*A^5]
rank(C_M)
