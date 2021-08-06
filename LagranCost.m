function value=LagranCost(IniSafeLqr,ObConsArray,lambda,K,l)
%calculate the value of the Lagrangian dual
value=0;
x=zeros(2,IniSafeLqr.n);
x(:,1)=IniSafeLqr.x0;
u=zeros(2,IniSafeLqr.n);
    for t=1:IniSafeLqr.n-1
        u(:,t)=(K{t}*x(:,t)+l(:,t));
        x(:,t+1)=IniSafeLqr.A*x(:,t)+IniSafeLqr.stepsize*IniSafeLqr.B*u(:,t);
        value=value+x(:,t)'*IniSafeLqr.Q*x(:,t)+u(:,t)'*IniSafeLqr.R*u(:,t);%primal cost
        for i=1:size(IniSafeLqr.h,2)
            value=value+ObConsArray(t).sign(i)*lambda(i,t)*x(:,t)'*ObConsArray(t).H{i}*x(:,t);%quadratic dual cost
            value=value+ObConsArray(t).sign(i)*lambda(i,t)*ObConsArray(t).c{i}'*x(:,t);%linear dual cost
            value=value+ObConsArray(t).sign(i)*lambda(i,t)*ObConsArray(t).d{i};
        end
    end

end