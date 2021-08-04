classdef ObCons
    properties
        t                    %time t
        h                   %constraints
        xt                  %state at time t
        flag               %flag means active or not
    end
    methods
        function obj=ObCons(t,h,xt)
            obj.flag=flag;
            obj.t=t;
            obj.h=h;
            obj.xt=xt;
        end
    end
    
end