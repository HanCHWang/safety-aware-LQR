function [a] = iscollision(ellipse)
% clear
% load matlab3
a=0;
if (length(ellipse)==1)
    return;
end
% for ii=1:length(ellipse)
%     ellidraw = ellipse{ii};
%     plot(ellidraw(:,1),ellidraw(:,2));
%     hold on
% end
for i=1:length(ellipse)
    ell_1 = floor(ellipse{i}.*10^5);
    clear ell_1_x_min ell_1_x_max ell_1_y_min ell_1_y_max points1_x points1_y;
    ell_1_x_min = min(ell_1(:,1));
    ell_1_x_max = max(ell_1(:,1));
    ell_1_y_min = min(ell_1(:,2));
    ell_1_y_max = max(ell_1(:,2));
    points1_x = ell_1_x_min:1:ell_1_x_max;
    points1_y = ell_1_y_min:1:ell_1_y_max;
    for j=i+1:length(ellipse)
        clear ell_2_x_min ell_2_x_max ell_2_y_min ell_2_y_max points2_x points2_y;
        ell_2 = floor(ellipse{j}.*10^5);
        ell_2_x_min = min(ell_2(:,1));
        ell_2_x_max = max(ell_2(:,1));
        ell_2_y_min = min(ell_2(:,2));
        ell_2_y_max = max(ell_2(:,2));
        points2_x = ell_2_x_min:1:ell_2_x_max;
        points2_y = ell_2_y_min:1:ell_2_y_max;
        if (intersect(points1_y,points2_y))
            if(intersect(points1_x,points2_x))
                a=1;
            end
        end
    end
end
end
