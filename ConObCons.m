%convexified constraints
classdef ConObCons
    properties
        H                  %Convexified Quadratic Term
        c                  %Convexified Linear Term
        d                  %Convexified Const Term
        t                   %time
        xt                 %state at time t
    end
    methods
        function obj = ConObCons(H,c,d,t,xt)
            obj.H = H;
            obj.c = c;
            obj.d = d;
            obj.t = t;
            obj.xt = xt;
        end
    end
    
end