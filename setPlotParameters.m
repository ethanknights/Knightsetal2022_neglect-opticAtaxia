%%quickly edit pointing plot parameters
xlabel('Normalised X Endpoint Coordinate (mm)');
ylabel('Normalised Y Endpoint Coordinate (mm)');
xlim([-300 300]);
ylim([150 275]);
set(gca,'box','off','color','none','TickDir','out','fontsize',18);
title(currConditionName);
grid on
% set(gcf,'color','w')