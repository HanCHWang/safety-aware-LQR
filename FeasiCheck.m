function flag=FeasiCheck(ReObCons)
flag=zeros(size(ReObCons.h,2),1);
    for i=1:size(ReObCons.h,2)
%         hmat=zeros(3,size(ReObCons.h,2));
%         hmat(:,i)=ReObCons.h{i};
        if (ReObCons.xt(1)-ReObCons.h{i}(1))^2+(ReObCons.xt(2)-ReObCons.h{i}(2))^2-ReObCons.h{i}(3)^2<=0
            flag(i)=1;
        else
            flag(i)=0;
        end
    end
end