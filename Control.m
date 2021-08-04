function [K,l]  = Control(ReSafeLqr,lambda,ObConsArray,PLQ)
    for t=1:ReSafeLqr.n
        Qlambda(t)=ReSafeLqr.Q;
        C(t)=0;
        d(t)=0;
         for i=1:size(ReSafeLqr.h)
             if ObConsArray(t).flag(i)==1
                 Qlambda(t)=Qlambda(t)+lambda(i,t)*ObConsArray(t).H(i);
                 C(t)=C(t)+lambda(i,t)*ObConsArray(t).c(i);
                 d(t)=d(t)+lambda(i,t)*ObConsArray(t).d(i);
             end
         end
    end
    F(1)=PLQ;
    Strans(1)=0;
    r(1)=0;
    for t=1:ReSafeLqr.n
        F(t+1)=F(t)+
        Strans(t+1)=C(t)'+
        r(t+1)=r(t)+d(t);
    end
end