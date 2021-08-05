%main function for the safety aware LQR in path planning
%2021.08.04 version 0.0.1, utilize primal-dual and dynamic programming for
%constrained LQR problem, active set strategy and convexification tool are
%performed

clear all
%%
%define quantities
n=50;
stepsize=0.001;
A=[1 0;
    0 1];
B=[1 0;
    0 1];
C=0;
D=0;%no output in this scenario
Q=[1 0;
    0 1];
R=[1 0;
    0 1];
h={[5*rand,5*rand,3*rand],[2*rand,2*rand,3*rand],[7*rand,7*rand,3*rand]};%multiple circle
flag=0;
x=zeros(2,n);%plane movement
x(:,1)=[10;10];
lambda=0;%no constraint initially
epsilon=1e-3;

for t=1:n
    ObConsArray(t)=ObCons(t,h,x(:,t),flag);
end
IniSafeLqr=SafeLqr(n,A,B,C,D,Q,R,h);
[K,l]=Control(IniSafeLqr,lambda,ObConsArray,[1 0;0 1]);%u=Kx+l

for t=1:n
    ObConsArray(t)=ObCons(t,h,x(:,t),flag);
    flag=FeasiCheck(ObConsArray(t));
    x(:,t+1)=A*x(:,t)+stepsize*B*(K{t}*x(:,t)+l(:,t));
end

while sum(ObConsArray.flag)>0
    
end







