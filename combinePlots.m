function [h] = combinePlots(thisVarStr,outImageDir,axisVal)


h1 = openfig('images/ANGerr_LHFREE.fig','reuse');
ax1 = gca;
h2 = openfig('images/ANGerr_RHFREE.fig','reuse')
ax2 = gca;
h3 = openfig('images/ANGerr_LHPER.fig','reuse')
ax3 = gca;
h4 = openfig('images/ANGerr_RHPER.fig','reuse')
ax4 = gca;


h5 = figure('position',[100,100,1200,1200]); %create new figure

s1 = subplot(2,2,1); %create and get handle to the subplot axes
title('Left Hand - Free Vision')
    %other formatting
    xlabel('Target Position (degrees from midline)')
    ylabel(thisVarStr)
    axis(axisVal);
    xticklabels({[],'-28','-17','-11','0','11','17','28'});
    set(gca,'box','off','color','none','TickDir','out');
    
s2 = subplot(2,2,2);
title('Right Hand - Free Vision')
    %other formatting
    xlabel('Target Position (degrees from midline)')
    ylabel(thisVarStr)
    axis(axisVal);
    xticklabels({[],'-28','-17','-11','0','11','17','28'});
    set(gca,'box','off','color','none','TickDir','out');
    
s3 = subplot(2,2,3); %create and get handle to the subplot axes
title('Left Hand - Peripheral Vision')
    %other formatting
    xlabel('Target Position (degrees from midline)')
    ylabel(thisVarStr)
    axis(axisVal);
    xticklabels({[],'-28','-17','-11','0','11','17','28'});
    set(gca,'box','off','color','none','TickDir','out');
    
s4 = subplot(2,2,4);
title('Right Hand - Peripheral Vision')
    %other formatting
    xlabel('Target Position (degrees from midline)')
    ylabel(thisVarStr)
    axis(axisVal);
    xticklabels({[],'-28','-17','-11','0','11','17','28'});
    set(gca,'box','off','color','none','TickDir','out');
    
    
fig1 = get(ax1,'children'); %get handle to all the children in the figure
fig2 = get(ax2,'children');
fig3 = get(ax3,'children');
fig4 = get(ax4,'children');

copyobj(fig1,s1); %copy children to new parent axes i.e. the subplot axes
copyobj(fig2,s2);
copyobj(fig3,s3);
copyobj(fig4,s4);

sgtitle(thisVarStr);

h = gcf;


%% save
outName = fullfile(outImageDir,thisVarStr);
cmdStr = sprintf('export_fig %s.tiff -transparent',outName)
eval(cmdStr);



end