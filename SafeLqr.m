classdef SafeLqr
    properties
        t                  %time horizon
        A                 %state matrix
        B                 %input matrix
        C                 %output state matrix
        D                 %output input matrix
        Q                 %state cost matrix
        R                 %input cost matrix
        h                  %constraints
    end
    
    methods
        
        r = control(obj)
        
    end
end