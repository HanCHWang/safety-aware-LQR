%main function for the safety aware LQR in path planning
%2021.08.04 version 0.0.1, utilize primal-dual and dynamic programming for
%constrained LQR problem, active set strategy and convexification tool are
%performed

clear all
%%
%define quantities
n=50;
stepsize=0.1;
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
flag=zeros(size(h,2));
sign=zeros(size(h,2));
x=zeros(2,n);%plane movement
x(:,1)=[10;10];
lambda=0;%no constraint initially
epsilon=5;

for t=1:n
    ObConsArray(t)=ObCons(t,h,x(:,t),flag,sign);
end
IniSafeLqr=SafeLqr(n,A,B,C,D,Q,R,h,x(:,1),stepsize);
[K,l]=Control(IniSafeLqr,lambda,ObConsArray,[1 0;0 1]);%u=Kx+l

flagsum=0;
for t=1:n-1
    ObConsArray(t)=ObCons(t,h,x(:,t),flag,sign);
    flag=FeasiCheck(ObConsArray(t),0);
    sign=FeasiCheck(ObConsArray(t),1);
    x(:,t+1)=A*x(:,t)+stepsize*B*(K{t}*x(:,t)+l(:,t));
    flagsum=flagsum+sum(flag);
end

value(1)=100000;
k=2;
while flagsum>0
    flagsum=0;
    [H,c,d]=Convexification(ObConsArray);
    for t=1:n
        ObConsArray(t)=ObCons(t,h,x(:,t),flag,sign,{H(:,t),c(:,t),d(:,t)});
        flag=FeasiCheck(ObConsArray(t),0);
        sign=FeasiCheck(ObConsArray(t),1);
        flagsum=flagsum+sum(flag);
    end
    [K,l,value(2)]=PrimalDual(IniSafeLqr,ObConsArray,epsilon);
    while value(k)<value(k-1)
        value(k)-value(k-1)
        [H,c,d]=Convexification(ObConsArray);
        for t=1:n
            ObConsArray(t)=ObCons(t,h,x(:,t),flag,sign,{H(:,t),c(:,t),d(:,t)});
        end
        [K,l,value(k+1)]=PrimalDual(IniSafeLqr,ObConsArray,epsilon);
        for t=1:n-1
            x(:,t+1)=A*x(:,t)+stepsize*B*(K{t}*x(:,t)+l(:,t));
        end

        k=k+1;
    end
end







