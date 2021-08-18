function a = isoutrange(areaStart,areaEnd,ellipse)
a=0;
for i = 1:length(ellipse)
    ell_1 = ellipse{i};
    clear ell_1_x_min ell_1_x_max ell_1_y_min ell_1_y_max points1_x points1_y;
    ell_1_x_min = min(ell_1(:,1));
    ell_1_x_max = max(ell_1(:,1));
    ell_1_y_min = min(ell_1(:,2));
    ell_1_y_max = max(ell_1(:,2));
    if (ell_1_x_min < areaStart(1))
        a=1;
    end
    if (ell_1_y_min < areaStart(2))
        a=1;
    end
    if (ell_1_x_max > areaEnd(1))
        a=1;
    end
    if (ell_1_y_max > areaEnd(2))
        a=1;
    end
end
end

