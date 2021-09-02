classdef ObCons
    properties
        t                   %time t
        h                   %constraints
        xt                  %state at time t
        flag               %flag means violate constraints or not
        sign              %sign means active the constraints or not
        %%%%%%H,c,d are stored in cell%%%%%%%
        H                  %Convexified Quadratic Term
        c                  %Convexified Linear Term
        d                  %Convexified Const Term
    end
    methods
        function obj=ObCons(t,h,xt,flag,sign,arg)
                obj.flag=flag;
                obj.t=t;
                obj.h=h;
                obj.xt=xt;
                obj.sign=sign;
            if nargin==5
                H=0;
                c=0;
                d=0;
            else
                obj.H=arg{1};
                obj.c=arg{2};
                obj.d=arg{3};
            end
            %             [obj.H,obj.c,obj.d]=Convexification(obj,arg);
        end
    end
    
end