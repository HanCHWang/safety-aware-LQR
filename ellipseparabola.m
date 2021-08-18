function [c,ceq]=ellipseparabola(x)
load matlab2
scatter_x = scatter_dots(:,1);
scatter_y = scatter_dots(:,2);
scatter_x2 = scatter_dots(:,1).^2;
scatter_y2 = scatter_dots(:,2).^2;
scatter_xy = scatter_x.*scatter_y;
scatter_1 = ones(length(scatter_x),1);
X = [scatter_x2, scatter_xy, scatter_y2, scatter_x, scatter_y, scatter_1];
%% QCQP”≈ªØ
% A = [a b c d e f]';
C = [0 0 0 0 0 0;
    0 -1 0 0 0 0;
     2 0 0 0 0 0;
     0 0 0 0 0 0;
     0 0 0 0 0 0;
     0 0 0 0 0 0;];
c = [
     X*[x(1) x(2) x(3) x(4) x(5) x(6)]';
     -x(1);
     -x(2);
     -x(3);
%      -4*x(1)*x(3)-x(2)^2;
    ];
% ceq=[];
ceq = [x(1) x(2) x(3) x(4) x(5) x(6)]*C*[x(1) x(2) x(3) x(4) x(5) x(6)]'-1;
