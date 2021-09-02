clear
close all
load ellipse5
for i = 1:length(ellipse)
    scatter_dots = ellipse{i};
    scatter_x = scatter_dots(:,1);
    scatter_y = scatter_dots(:,2);
    scatter(scatter_x,scatter_y);
    hold on
end
new_ellipse = ellipse;
load scatter4
for i = 1:length(ellipse)-1
    scatter_dots = ellipse{i};
    scatter_dots(:,1) = scatter_dots(:,1)+4;
    scatter_dots(:,2) =scatter_dots(:,2)+0.7;
    scatter_x = scatter_dots(:,1);
    scatter_y = scatter_dots(:,2);
    scatter(scatter_x,scatter_y);
    hold on
    ellipse{i} = scatter_dots;
end
new_ellipse = [new_ellipse,ellipse(1)];
for i = 2
    scatter_dots = ellipse{i};
    scatter_dots(:,1) = scatter_dots(:,1)+0.5;
    scatter_dots(:,2) =scatter_dots(:,2)-0.5;
    scatter_x = scatter_dots(:,1);
    scatter_y = scatter_dots(:,2);
    scatter(scatter_x,scatter_y);
    hold on
    ellipse{i} = scatter_dots;
end
new_ellipse = [new_ellipse,ellipse(2)];
load scatter1
for i = 2
    scatter_dots = ellipse{i};
    scatter_dots(:,1) = scatter_dots(:,1)+2;
    scatter_dots(:,2) =scatter_dots(:,2)+0.2;
    scatter_x = scatter_dots(:,1);
    scatter_y = scatter_dots(:,2);
    scatter(scatter_x,scatter_y);
    hold on
    ellipse{i} = scatter_dots;
end
new_ellipse = [new_ellipse,ellipse(2)];
ellipse  = new_ellipse;
