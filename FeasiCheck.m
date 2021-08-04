function flag=FeasiCheck(ReObCons)
flag=zeros(size(ReObCons.h),1);
    for i=1:size(ReObCons.h)
        if ReObCons.xt>=h(i)
            flag(i)=1;
        else
            flag(i)=0;
        end
    end
end