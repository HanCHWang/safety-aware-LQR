function [K,l]  = Control(ReSafeLqr,lambda,ObConsArray,PLQ)
    for t=1:ReSafeLqr.n
        Qlambda{t}=ReSafeLqr.Q;
        C{t}=0;
        d(t)=0;
         for i=1:size(ReSafeLqr.h)
             if ObConsArray(t).flag(i)==1
                 Qlambda{t}=cell2mat(Qlambda{t})+lambda(i,t)*ObConsArray(t).H(i);
                 C{t}=cell2mat(C{t})+lambda(i,t)*ObConsArray(t).c(i);
                 d(t)=d(t)+lambda(i,t)*ObConsArray(t).d(i);
             end
         end
    end
    F=cell(1,ReSafeLqr.n);
    Strans=cell(1,ReSafeLqr.n);
    r=zeros(1,ReSafeLqr.n);
    K=cell(1,ReSafeLqr.n);
    l=zeros(2,ReSafeLqr.n);
    F{ReSafeLqr.n}=PLQ;
    Strans{ReSafeLqr.n}=[0 0];
    r(ReSafeLqr.n)=0;
    for t=ReSafeLqr.n:-1:2
        F{t-1}=-ReSafeLqr.A'*F{t}*ReSafeLqr.B*(ReSafeLqr.B'*F{t}*ReSafeLqr.B+ReSafeLqr.R)^(-1)*ReSafeLqr.B'*F{t}*ReSafeLqr.A+Qlambda{t}+ReSafeLqr.A'*F{t}*ReSafeLqr.A;
        Strans{t-1}=C{t}'+Strans{t}*ReSafeLqr.A;
        r(t-1)=d(t)+r(t);
        K{t-1}=-(ReSafeLqr.R+ReSafeLqr.B'*F{t}*ReSafeLqr.B)^(-1)*(ReSafeLqr.B'*F{t}*ReSafeLqr.A);
        l(:,t-1)=-(ReSafeLqr.R+ReSafeLqr.B'*F{t}*ReSafeLqr.B)^(-1)*ReSafeLqr.B'*Strans{t}';
    end
    
end