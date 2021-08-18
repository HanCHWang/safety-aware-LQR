function [HH, CC, DD] = elliregresstest(scatter_dots)
save matlab2 scatter_dots;

load matlab2
scatter_x = scatter_dots(:,1);
scatter_y = scatter_dots(:,2);
scatter_x2 = scatter_dots(:,1).^2;
scatter_y2 = scatter_dots(:,2).^2;
scatter_xy = scatter_x.*scatter_y;
scatter_1 = ones(length(scatter_x),1);
X = [scatter_x2, scatter_xy, scatter_y2, scatter_x, scatter_y, scatter_1];
%% QCQPÓÅ»¯
% A = [a b c d e f]';
C = [0 0 2 0 0 0;
    0 -1 0 0 0 0;
     2 0 0 0 0 0;
     0 0 0 0 0 0;
     0 0 0 0 0 0;
     0 0 0 0 0 0;];
fun = @(x)sum((X*[x(1) x(2) x(3) x(4) x(5) x(6)]').^2);
nonlcon = @ellipseparabola;
x0 = [1 1 1 -1 -1 0];
A = []; % No other constraints
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];
data = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon);
HH = [data(1), 0; data(2), data(3)];
CC = [data(4), data(5)];
DD = data(6);
scatter(scatter_x,scatter_y);
hold on
syms x y;
X = [x^2;x*y;y^2;x;y;1];
ellipse = data*X;
ezplot(ellipse);
end


% ellipsefig2(x(1),x(2),x(3),x(4),x(5),x(6));


% n = 6;
% c = [0 0 2 0 0 0;
%     0 -1 0 0 0 0;
%      2 0 0 0 0 0;
%      0 0 0 0 0 0;
%      0 0 0 0 0 0;
%      0 0 0 0 0 0;];
% % m = 20;
% % p = 4;
% % A = randn(m,n); b = randn(m,1);
% % C = randn(p,n); d = randn(p,1); e = rand;
% cvx_begin
%     variable A(n)
%     minimize( norm( x * A ) )
%     subject to
% %          A'*c*A >0
%          for i = 1:100
%              x(i,:)*A<=0
%          end
%          for i=1:6
%              A(i)>0.0000001
%          end
% cvx_end
% plot(scatter_x,scatter_y)
% hold on
% ellipsefig2(A(1),A(2),A(3),A(4),A(5),A(6))