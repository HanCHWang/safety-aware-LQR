function [K,l,value]=PrimalDual(IniSafeLqr,ObConsArray,epsilon)
k=2;
alpha=0.01*1/k;
lambda=zeros(size(IniSafeLqr.h,2),IniSafeLqr.n);
x=zeros(2,IniSafeLqr.n);
x(:,1)=IniSafeLqr.x0;
u=zeros(2,IniSafeLqr.n);
%global mode, for local case dual variable should be stored seperately
%to svae memory
[K,l]=Control(IniSafeLqr,lambda,ObConsArray,[1 0;0 1]);
value(1)=0;
value(2)=LagranCost(IniSafeLqr,ObConsArray,lambda,K,l);
for t=1:IniSafeLqr.n-1
    u(:,t)=(K{t}*x(:,t)+l(:,t));
    x(:,t+1)=IniSafeLqr.A*x(:,t)+IniSafeLqr.stepsize*IniSafeLqr.B*u(:,t);
    for i=1:size(IniSafeLqr.h,2)
        lambda(i,t)=lambda(i,t)+alpha*ObConsArray(t).sign(i)*(x(:,t)'*ObConsArray(t).H{i}*x(:,t)+ObConsArray(t).c{i}'*x(:,t)+ObConsArray(t).d{i});
    end
end

while abs(value(k)-value(k-1))>epsilon%terminal condition
    [K,l]=Control(IniSafeLqr,lambda,ObConsArray,[1 0;0 1]);
    for t=1:IniSafeLqr.n-1
        u(:,t)=(K{t}*x(:,t)+l(:,t));
        x(:,t+1)=IniSafeLqr.A*x(:,t)+IniSafeLqr.stepsize*IniSafeLqr.B*u(:,t);
        for i=1:size(IniSafeLqr.h,2)
            lambda(i,t)=lambda(i,t)+alpha*ObConsArray(t).sign(i)*(x(:,t)'*ObConsArray(t).H{i}*x(:,t)+ObConsArray(t).c{i}'*x(:,t)+ObConsArray(t).d{i});
            if lambda(i,t)<0
                lambda(i,t)=0;
            end
        end
    end
    value(k+1)=LagranCost(IniSafeLqr,ObConsArray,lambda,K,l);
    k=k+1;
    alpha=0.01*1/k;
    value(k)-value(k-1)
end
value=value(k);
end