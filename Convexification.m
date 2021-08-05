function [H,c,d]=Convexification(ObConsArray)
%decide whether current state is feasible or not

for i=1:size(ObConsArray(1).h,2)
    for t=1:size(ObConsArray,2)
        if ObConsArray(t).flag(i)==0%constraint not violate
            H{i,t}=0;
            c{i,t}=-[2*ObConsArray(t).xt(1)-2*ObConsArray(t).h{i}(1);2*ObConsArray(t).xt(2)-2*ObConsArray(t).h{i}(2)];
            d{i,t}=(ObConsArray(t).xt(1)-ObConsArray(t).h{i}(1))^2+(ObConsArray(t).xt(2)-ObConsArray(t).h{i}(2))^2-ObConsArray(t).h{i}(2)^2-c{t}'*ObConsArray(t).xt;
            FeasiMax=t;%maximum feasible time step
        elseif ObConsArray(t).flag(i)==1&&ObConsArray(t).sign(i)==1
            %use the preceding feasible searching space in substitution
            H{i,t}=H{i,FeasiMax};
            c{i,t}=c{i,FeasiMax};
            d{i,t}=d{i,FeasiMax};
        end
    end
end
end