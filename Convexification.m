function [H,c,d]=Convexification(ObConsArray)
%decide whether current state is feasible or not

for t=1:size(ObConsArray,2)
    if ObConsArray(t).flag(1)==0&&ObConsArray(t).sign(1)==1%constraint not violate
        H{t}=0;
        c{t}=-[2*ObConsArray(t).xt(1)-2*ObConsArray(t).h{1}(1);2*ObConsArray(t).xt(2)-2*ObConsArray(t).h{1}(2)];
        d{t}=(ObConsArray(t).xt(1)-ObConsArray(t).h{1}(1))^2+(ObConsArray(t).xt(2)-ObConsArray(t).h{1}(2))^2-ObConsArray(t).h{1}(2)^2-c{t}'*ObConsArray(t).xt;
        FeasiMax=t;%maximum feasible time step
    elseif ObConsArray(t).flag(1)==1&&ObConsArray(t).sign(1)==1
        %use the preceding feasible searching space in substitution
        H{t}=H{FeasiMax};
        c{t}=c{FeasiMax};
        d{t}=d{FeasiMax};
    end
end
end