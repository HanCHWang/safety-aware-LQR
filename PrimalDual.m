function [K,l,value]=PrimalDual(IniSafeLqr,ObConsArray,epsilon)
k=2;
alpha=0.001;
lambda=10*ones(size(IniSafeLqr.h,2),IniSafeLqr.n);
lambdahat=10*ones(size(IniSafeLqr.e,1),IniSafeLqr.n);
x=zeros(2,IniSafeLqr.n);
x(:,1)=IniSafeLqr.x0;
u=zeros(2,IniSafeLqr.n);
%global mode, for local case dual variable should be stored seperately
%to svae memory
[K,l]=Control(IniSafeLqr,lambda,lambdahat,ObConsArray,[20 1;0 30]);
value(1)=0;
value(2)=LagranCost(IniSafeLqr,ObConsArray,lambda,lambdahat,K,l);
for t=1:IniSafeLqr.n-1
    u(:,t)=(K{t}*x(:,t)+l(:,t));
    x(:,t+1)=IniSafeLqr.A*x(:,t)+IniSafeLqr.stepsize*IniSafeLqr.B*u(:,t);
    for i=1:size(IniSafeLqr.h,2)
        if ~isempty(ObConsArray(t).H{1})
            lambda(i,t)=lambda(i,t)+alpha*ObConsArray(t).sign(i)*(x(:,t)'*ObConsArray(t).H{i}*x(:,t)+ObConsArray(t).c{i}'*x(:,t)+ObConsArray(t).d{i});
        end
        lambdahat(:,t)=lambdahat(:,t)+alpha*(IniSafeLqr.G*u(:,t)-IniSafeLqr.e);
    end
    for i=1:size(IniSafeLqr.G,1)
        if lambdahat(i,t)<0
            lambdahat(i,t)=0;
        end
    end
end

while abs(value(k)-value(k-1))>epsilon&&k<10000%terminal condition
    [K,l]=Control(IniSafeLqr,lambda,lambdahat,ObConsArray,[20 0;0 30]);
    for t=1:IniSafeLqr.n-1
        u(:,t)=(K{t}*x(:,t)+l(:,t));
        %         if u(1,t)>=0.3
        %             u(1,t)=0.3;
        %         elseif u(1,t)<=-0.3
        %             u(1,t)=-0.3;
        %         end
        %
        %         if u(2,t)>0.3
        %             u(2,t)=0.3;
        %         elseif u(2,t)<-0.3
        %             u(2,t)=-0.3;
        %         end
        
        x(:,t+1)=IniSafeLqr.A*x(:,t)+IniSafeLqr.stepsize*IniSafeLqr.B*u(:,t);
        lambdahat(:,t)=lambdahat(:,t)+alpha*(IniSafeLqr.G*u(:,t)-IniSafeLqr.e);
        for i=1:size(IniSafeLqr.G,1)
            if lambdahat(i,t)<0
                lambdahat(i,t)=0;
            end
        end
        for i=1:size(IniSafeLqr.h,2)
            if ~isempty(ObConsArray(t).H{1})
                lambda(i,t)=lambda(i,t)+alpha*ObConsArray(t).sign(i)*(x(:,t)'*ObConsArray(t).H{i}*x(:,t)+ObConsArray(t).c{i}'*x(:,t)+ObConsArray(t).d{i});
            end
            if lambda(i,t)<0
                lambda(i,t)=0;
            end
        end
    end
    value(k+1)=LagranCost(IniSafeLqr,ObConsArray,lambda,lambdahat,K,l);
    k=k+1;
    alpha=0.001;
    %     value(k)-value(k-1)
end
value=value(k);
end