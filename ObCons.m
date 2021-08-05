classdef ObCons
    properties
        t                    %time t
        h                   %constraints
        xt                  %state at time t
        flag               %flag means active or not
        %%%%%%H,c,d are stored in cell%%%%%%%
        H                  %Convexified Quadratic Term
        c                  %Convexified Linear Term
        d                  %Convexified Const Term
    end
    methods
        function obj=ObCons(t,h,xt,flag)
            obj.flag=flag;
            obj.t=t;
            obj.h=h;
            obj.xt=xt;
%             [obj.H,obj.c,obj.d]=Convexified(obj);
        end
    end
    
end