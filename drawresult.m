clear
close all
load better2
% data_h = h{i}
% HH = [data(1), 0; data(2), data(3)];
% CC = [data(4), data(5)];
% DD = data(6);
% scatter(scatter_x,scatter_y);
% hold on
% syms x y;
% X = [x^2;x*y;y^2;x;y;1];
% ellipse = data*X;
% ezplot(ellipse);
% hold on
for i=1:5
    data_h = Hellipsoid{i};
    data_c = Cellipsoid{i};
    data_d = Dellipsoid{i};
    data(1) = data_h(1,1);
    data(2) = data_h(2,1);
    data(3) = data_h(2,2);
    data(4:5) = data_c;
    data(6) = data_d;
    syms xx yy;
X = [xx^2;xx*yy;yy^2;xx;yy;1];
ellipse = data*X;
ezplot(ellipse);
%     data = ellipse{i};
%     plot(data(:,1),data(:,2));
    hold on
end
% x(1,:) = smooth(x(1,:),2);
% x(2,:) = smooth(x(2,:),2);
plot(x(1,:),x(2,:));