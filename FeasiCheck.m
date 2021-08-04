function flag=FeasiCheck(ReObCons)
    if ReObCons.xt>=h
        flag=1;
    else
        flag=0;
    end
end