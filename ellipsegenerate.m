function ellipse = ellipsegenerate(P,N,areaStart,areaEnd,dis)
%% �������N����Բ����֤�������ཻ���������ɢ��
% ����
% clear
% P = 0.15; % ��Բ���������
% N = 10;
% areaStart = [0,0];
% areaEnd = [10,10];
% dis = 0; %���
% ���N����Բ����������������P*area
N=N+1;
area = abs(areaStart(1)-areaEnd(1))*abs(areaStart(2)-areaEnd(2));
total_areaEllipse = P*area;
x=rand(1,N);
y=sum(x);
areaEllipse=x/y*total_areaEllipse;
%% �������������������Բ
P1 = 0.3+rand(N,1)*0.7;%������״
P2 = (rand(N,1)-0.5).*180;%����Ƕ� -180��180
%��ʼ�ɰڷ�λ��
Pos(1,:) = areaStart;

% �ҵ㣬���
% �ŵ�i��Բ
% �ж�
% �ɹ� ����
% ʧ�� �����ҵ�����
% ���ȫ�������У�i-1
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
        %��Բ
        L_a(i) = sqrt(areaEllipse(i)/( 2 * P1(i)));
        L_b(i) = P1(i)*L_a(i);
        Pos_x(i) = L_a(i)+Pos_selected(1)+dis;
        Pos_y(i) = L_a(i)+Pos_selected(2)+dis;
        ecc = axes2ecc(L_a(i),L_b(i));
        [ex,ey] = ellipse1(Pos_x(i),Pos_y(i),[L_a(i) ecc],P2(i));
        ellipse{i}=[ex,ey];
        %         plot(ex,ey);
        % �ж��Ƿ����
%         (~iscollision(ellipse))&&(~isoutrange(areaStart,areaEnd,ellipse))
        if ((~iscollision(ellipse))&&(~isoutrange(areaStart,areaEnd,ellipse))) % �������
            %             plot(ex,ey);
            %             hold on;
            MAX_elat = max(ex);
            MAX_elon = max(ey);
            clear ex ey;
            % ��һ��ͼ���������ʼλ��
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
            continue;%����jjѭ��
            %         elseif ()%��������� ����ѡ
            %             ellipse(i)=[];
            %
        elseif (size(Pos_temp,1)==0) %���û��ѡ
            ellipse(i)=[];
            i=i-1;% ��ǰһ��Բ��ʼ
            
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
