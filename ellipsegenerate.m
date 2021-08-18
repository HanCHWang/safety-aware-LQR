function ellipse = ellipsegenerate(P,N,areaStart,areaEnd,dis)
%% 随机生成N个椭圆，保证两两不相交，最后生成散点
% 参数
% clear
% P = 0.15; % 椭圆总面积比例
% N = 10;
% areaStart = [0,0];
% areaEnd = [10,10];
% dis = 0; %间隔
% 随机N个椭圆面积，总面积不超过P*area
N=N+1;
area = abs(areaStart(1)-areaEnd(1))*abs(areaStart(2)-areaEnd(2));
total_areaEllipse = P*area;
x=rand(1,N);
y=sum(x);
areaEllipse=x/y*total_areaEllipse;
%% 深度优先搜索，生成椭圆
P1 = 0.3+rand(N,1)*0.7;%椭球形状
P2 = (rand(N,1)-0.5).*180;%椭球角度 -180，180
%初始可摆放位置
Pos(1,:) = areaStart;

% 找点，存点
% 放第i个圆
% 判断
% 成功 增点
% 失败 重新找点生成
% 如果全部都不行，i-1
Pospool{1} = Pos;
j=2;
i=1;
while (i<N)
    for jj=1:size(Pospool{i},1)
        Pos_record = unidrnd(size(Pospool{i},1));
        Pos_temp = Pospool{i};
        Pos_selected = Pos_temp(Pos_record,:);
        Pos_temp(Pos_record,:) = [];
        Pospool{i} = Pos_temp;
        %放圆
        L_a(i) = sqrt(areaEllipse(i)/( 2 * P1(i)));
        L_b(i) = P1(i)*L_a(i);
        Pos_x(i) = L_a(i)+Pos_selected(1)+dis;
        Pos_y(i) = L_a(i)+Pos_selected(2)+dis;
        ecc = axes2ecc(L_a(i),L_b(i));
        [ex,ey] = ellipse1(Pos_x(i),Pos_y(i),[L_a(i) ecc],P2(i));
        ellipse{i}=[ex,ey];
        %         plot(ex,ey);
        % 判断是否合适
%         (~iscollision(ellipse))&&(~isoutrange(areaStart,areaEnd,ellipse))
        if ((~iscollision(ellipse))&&(~isoutrange(areaStart,areaEnd,ellipse))) % 如果合适
            %             plot(ex,ey);
            %             hold on;
            MAX_elat = max(ex);
            MAX_elon = max(ey);
            clear ex ey;
            % 下一个图像的三个初始位置
            if (MAX_elat>Pos_selected(1))
                Pos(j,:) = [MAX_elat,Pos_selected(2)];
                j=j+1;
            end
            if (MAX_elon>Pos_selected(2))
                Pos(j,:) = [Pos_selected(1),MAX_elon];
                j=j+1;
            end
            if ((MAX_elon>Pos_selected(2))&&(MAX_elat>Pos_selected(1)))
                Pos(j,:) = [MAX_elat,MAX_elon];
                j=j+1;
            end
            Pospool{i+1} = Pos;
            
            i=i+1;
            if (length(ellipse)==N)
                break;
            end
            continue;%跳出jj循环
            %         elseif ()%如果不合适 重新选
            %             ellipse(i)=[];
            %
        elseif (size(Pos_temp,1)==0) %如果没得选
            ellipse(i)=[];
            i=i-1;% 从前一个圆开始
            
            continue;
        end
    end
    if isempty(Pospool{2})
        break;
    end
    if (i==N)
        break;
    end
end
% for ii=1:N
%     ellidraw = ellipse{ii};
%     plot(ellidraw(:,1),ellidraw(:,2));
%     hold on
% end
ellipse(N)=[];
end
