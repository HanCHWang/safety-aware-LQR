function [K,l]  = Control(ReSafeLqr,lambda,ObConsArray)
    [H,C,d]=Convexification(ReSafeLqr);
    Qlambda=;%got from convexification
    Sn=C'*lambda(ReSafeLqr.n);
    rn=d;
end