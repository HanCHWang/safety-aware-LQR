%main function for the safety aware LQR in path planning
%2021.08.04 version 0.0.1, utilize primal-dual and dynamic programming for
%constrained LQR problem, active set strategy and convexification tool are
%performed

clear all
%%
%define quantities
n=;
A=;
B=;
C=;
D=;
Q=;
R=;
h=;
flag=0;
x=zeros(n,2);%plane movement
lambda=0;%no constraint initially
epsilon=1e-3;

IniSafeLqr=SafeLqr(n,A,B,C,D,Q,R,h);
[K,l]=control(IniSafeLqr,lambda);%u=Kx+l

for i=1:n
    FeasiCheck()
    ObConsArray(i)=ObCons(i,h,x(i),flag);
    x(i+1)=A*x(i)+B*(K*x(i)+l);
end

while sum(ObConsArray.flag)>0
    
end







