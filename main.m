%main function for the safety aware LQR in path planning
%2021.08.04 version 0.0.1, utilize primal-dual and dynamic programming for
%constrained LQR problem, active set strategy and convexification tool are
%performed

clear all
%%
%define quantities
n=50;
stepsize=1;
A=[1 0;
    0 1];
B=[1 0;
    0 1];
C=0;
D=0;%no output in this scenario
Q=[1 0;
    0 1];
R=[50 0;
    0 50];
G=[1 0;
    0 1;
    -1 0;
    0 -1];
e=[0.5;
    0.5;
    0.5;
    0.5];
% h={[5*rand,5*rand,3*rand],[2*rand,2*rand,3*rand],[7*rand,7*rand,3*rand]};%multiple circle
h={[2,2,1]};
H=cell(size(h,2),n);
c=cell(size(h,2),n);
d=cell(size(h,2),n);
flag=zeros(size(h,2));
sign=zeros(size(h,2));
x=zeros(2,n);%plane movement
x(:,1)=[5;4];
lambda=zeros(size(h,2),n);%no constraint initially
lambdahat=ones(size(G,1),n);
epsilon=0.03;


for t=1:n
    ObConsArray(t)=ObCons(t,h,x(:,t),flag,sign,{H(:,t),c(:,t),d(:,t)});
end
IniSafeLqr=SafeLqr(n,A,B,C,D,Q,R,h,G,e,x(:,1),stepsize);
% [K,l]=Control(IniSafeLqr,lambda,lambdahat,ObConsArray,[1 0;0 1]);%u=Kx+l
[K,l]=PrimalDual(IniSafeLqr,ObConsArray,epsilon);

flagsum=0;
u=zeros(2,IniSafeLqr.n);
for t=1:n-1
    ObConsArray(t).xt=x(:,t);
    flag=FeasiCheck(ObConsArray(t),0);
    sign=FeasiCheck(ObConsArray(t),1);
    ObConsArray(t).flag=flag;
    ObConsArray(t).sign=sign;
    u(:,t)=(K{t}*x(:,t)+l(:,t));
%     if u(1,t)>=0.3
%         u(1,t)=0.3;
%     elseif u(1,t)<=-0.3
%         u(1,t)=-0.3;
%     end
%     
%     if u(2,t)>0.3
%         u(2,t)=0.3;
%     elseif u(2,t)<-0.3
%         u(2,t)=-0.3;
%     end
    x(:,t+1)=A*x(:,t)+stepsize*B*u(:,t);
    flagsum=flagsum+sum(flag);
end

value(1)=100000;
k=2;
while flagsum>0
    flagsum=0;
    signsum=0;
    [H,c,d]=Convexification(ObConsArray);
    for t=1:n
        flag=FeasiCheck(ObConsArray(t),0);
        flagsum=flagsum+flag;
        sign=FeasiCheck(ObConsArray(t),1);
        signsum=signsum+sign;
%         sign=1;%have a try at active all the constraints
        ObConsArray(t)=ObCons(t,h,x(:,t),flag,sign,{H(:,t),c(:,t),d(:,t)});
    end
%     syms xx
%     fun=-c{6}(1)/c{6}(2)*xx-d{6}/c{6}(2);
%     plot(x(1,:),x(2,:));
%     hold on
%     viscircles([2,1],1);
%     hold on
%     ezplot(fun);
%     hold on
    [K,l,value(2)]=PrimalDual(IniSafeLqr,ObConsArray,epsilon);
    %first test general cases without convex-to-concave
        while value(k)<value(k-1)
    %         value(k)-value(k-1)
            [H,c,d]=Convexification(ObConsArray);
            for t=1:n
                ObConsArray(t).H=H(:,t);
                ObConsArray(t).c=c(:,t);
                ObConsArray(t).d=d(:,t);
                %             ObConsArray(t)=ObCons(t,h,x(:,t),flag,sign,{H(:,t),c(:,t),d(:,t)});
            end
            [K,l,value(k+1)]=PrimalDual(IniSafeLqr,ObConsArray,epsilon);
            for t=1:n-1
                x(:,t+1)=A*x(:,t)+stepsize*B*(K{t}*x(:,t)+l(:,t));
            end
    
            k=k+1;
        end
        flagsum=0;
        signsum=0;
        for t=1:n
            flag=FeasiCheck(ObConsArray(t),0);
            flagsum=flagsum+flag;
            sign=FeasiCheck(ObConsArray(t),1);
            signsum=signsum+sign;
            ObConsArray(t)=ObCons(t,h,x(:,t),flag,sign,{H(:,t),c(:,t),d(:,t)});
        end
    %     signsum
    %     flagsum
    for t=1:n-1
        x(:,t+1)=A*x(:,t)+stepsize*B*(K{t}*x(:,t)+l(:,t));
        ObConsArray(t).xt=x(:,t);
    end
    value(1)=100000;
    k=2;
end







