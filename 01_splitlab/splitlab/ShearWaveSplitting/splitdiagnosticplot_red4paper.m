function splitdiagnosticplot(Q, T, extime, L, E, N, inc, bazi,sampling, maxtime, pol,...
    phiRC, dtRC, Cmatrix, corFSrc, QTcorRC,...
    phiSC, dtSC, Ematrix, corFSsc, QTcorSC,...
    phiEV, dtEV, LevelSC, LevelRC, LevelEV, splitoption)

% display the results of a Rotation-Correlation and a minimum Energy
% splitting procedure in a single plot
% Inputs are expected in the following order:
%     Q, T
%     E, N
%     inclination, backazimuth, sampling [sec]
%     phiRC
%     dtRC
%     Cmatrix
%     corFastSlowparticleRC - corrected RC particle motion [F S]
%     phiSC
%     dtSC
%     pol: initial polarisation
%     Ematrix
%     sampling
%     corFastSlowparticleSC - corrected SC particle motion [F S]
%     Phi_errorSC   - SC fast axis estimation error interval
%     dt_errorSC    - SC delay time estimation error interval
%     Level         - confidence level for Silver&Chan Energy map

% Andreas Wüstefeld, 12.03.06

global thiseq config

Synfig = findobj('name', 'Diagnostic Viewer','type','figure');
if isempty(Synfig)
    S = get(0,'Screensize');
    Synfig = figure('name', 'Diagnostic Viewer',...
        'Renderer',        'painters',...
        'Color',           'w',...
        'NumberTitle',     'off',...
        'MenuBar',         'none',...
        'PaperType',       config.PaperType,...
        'PaperOrientation','landscape',...
        'PaperUnits',      'centimeter',...
        'position',        [.01*S(3) .1*S(4) .85*S(3) .45*S(4)]);
%        'position',        [.01*S(3) .1*S(4) .98*S(3) .75*S(4)]);
else
    figure(Synfig)
    clf
    set(Synfig,'PaperOrientation','landscape',...
        'PaperType',       config.PaperType)
end
orient landscape
colormap(gray)

fontsize = 16;
titlefontsize = fontsize+1;

[axSC] = splitdiagnosticLayout(Synfig);
%splitdiagnosticSetHeader(axH, phiRC, dtRC, phiSC, dtSC, phiEV, dtEV, pol, splitoption)

%=============================================================
% by RP and MG
% Save the misfit space:
thiseq.tmpresult.Cmatrix = Cmatrix;
thiseq.tmpresult.Ematrix = Ematrix(:,:,1);  % energymap for SC
thiseq.tmpresult.EVmatrix = Ematrix(:,:,2); % EVmap for SC depending on the selecting setting

%=============================================================

switch splitoption
    case 'Minimum Energy'
        Ematrix = Ematrix(:,:,1);
        optionstr ='Minimum Energy';
        phi = phiSC(2);
        dt  = dtSC(2);
        Level = LevelSC;
        Maptitle = 'Energy Map of T';
    case 'Eigenvalue: max(lambda1 / lambda2)'
        Ematrix = Ematrix(:,:,2);
        optionstr ='Maximum   \lambda_1 / \lambda_2';
        phi = phiEV(2);
        dt  = dtEV(2);
        Level =LevelEV;
        Maptitle = 'Map of Eigenvalues \lambda_1 / \lambda_2';
    case 'Eigenvalue: min(lambda2)'
        Ematrix = Ematrix(:,:,2);
        optionstr ='Minimum  \lambda_2';
        phi = phiEV(2);
        dt  = dtEV(2);
        Level =LevelEV;
        Maptitle = 'Map of Eigenvalue \lambda_2';
        
    case 'Eigenvalue: max(lambda1)'
        Ematrix = Ematrix(:,:,2);
        optionstr ='Maximum  \lambda_1';
        phi = phiEV(2);
        dt  = dtEV(2);
        Level =LevelEV;
        Maptitle = 'Map of Eigenvalue \lambda_1';

    case 'Eigenvalue: min(lambda1 * lambda2)'
        Ematrix = Ematrix(:,:,2);
        optionstr ='Minimum   \lambda_1 * \lambda_2';
        phi = phiEV(2);
        dt  = dtEV(2);
        Level =LevelEV;
        Maptitle = 'Map of Eigenvalues \lambda_1 * \lambda_2';
end


%% rotate seismograms for plots (backwards == counter-clockwise => use transposed matrix M)
M = rot3D(inc, bazi);

ZEN = M' *[L,  QTcorRC]';
Erc = ZEN(2,:); 
Nrc = ZEN(3,:);

ZEN = M' *[L,  QTcorSC]';
Esc = ZEN(2,:); 
Nsc = ZEN(3,:);

s = size(QTcorRC,1);%selection length


%% x-values for seismogram plots
t = (0:(s-1))*sampling;

%{
%%  Rotation-Correlation Method% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fast/slow seismograms
axes(axRC(1))
sumFS1 = sum(abs( corFSrc(:,1) -corFSrc(:,2)));
sumFS2 = sum(abs(-corFSrc(:,1) -corFSrc(:,2)));
if ( sumFS1 < sumFS2 )
    sig = 1;
else
    sig = -1;
end
m1 = max(abs( corFSrc(:,1)));
m2 = max(abs( corFSrc(:,2)));
plot(t, corFSrc(:,1)/m1,'b--',   t,sig*corFSrc(:,2)/m2,'r-','LineWidth',1);
xlim([t(1) t(end)])
%title(['corrected Fast (' char([183 183]) ') & Slow(-)'],'FontSize',titlefontsize);
title(['corrected Fast (\color{blue}--\color{black}) & Slow (\color{red}-\color{black})'],'FontSize',titlefontsize);
set(gca,'Ytick' , [-1 0 1])
ylabel('Rotation Correlation','FontSize',titlefontsize)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% corrected seismograms
axes(axRC(2))
plot(t, QTcorRC(:,1),'b--',    t, QTcorRC(:,2) ,'r-','LineWidth',1);
%title([' corrected Q(' char([183 183]) ') & T(-)'],'FontSize',titlefontsize);
title([' corrected Q (\color{blue}--\color{black}) & T (\color{red}-\color{black})'],'FontSize',titlefontsize);
xlim([t(1) t(end)])


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% surface Particle motion
axes(axRC(3))
hold on
grid on
plot(E, N, 'b--', Erc, Nrc,'r-','LineWidth',1);
xlabel('\leftarrowW - E\rightarrow', 'Fontsize',fontsize);
ylabel('\leftarrowS - N\rightarrow', 'Fontsize',fontsize);
%title(['Particle motion before (' char([183 183]) ') & after (-)'],'FontSize',titlefontsize);
title(['Particle motion before (\color{blue}--\color{black}) & after (\color{red}-\color{black})'],'FontSize',titlefontsize);
axis equal

tmp = max([abs(xlim) abs(ylim)]);%set [0 0] to centre of plot
set(gca, 'xlim', [-tmp tmp], 'ylim', [-tmp tmp], 'XtickLabel',[], 'YtickLabel',[])
set(gca, 'Ytick', get(gca,'Xtick'))
hold on
X = sin(bazi/180*pi)*tmp;
Y = cos(bazi/180*pi)*tmp;
plot( [-X X], [-Y Y], 'k:' )
text(0.57,0.98,['BAZ = ' num2str(thiseq.bazi,'%.1f') '°'], ...
	'Color','k','FontSize',fontsize, ...
	'Units','normalized', 'VerticalAlignment','top', 'HorizontalAlignment','left')
text(0.03,0.98,thiseq.dstr, ...
	'Color','k','FontSize',fontsize, ...
	'Units','normalized', 'VerticalAlignment','top', 'HorizontalAlignment','left')
text(0.025,0.15,['[' num2str(thiseq.results.filter(1)) ',' num2str(thiseq.results.filter(2)) '] Hz'], ...
	'Color','k','FontSize',fontsize, ...
	'Units','normalized', 'VerticalAlignment','top', 'HorizontalAlignment','left')
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Correlation Map
axes(axRC(4))
hold on
f  = size(Cmatrix);
ts = linspace(0,maxtime,f(2));
ps = linspace(-90,90,f(1));

maxi = max(Cmatrix(:));% allways <=  1 since correlation coeffcient (^5)
mini = min(Cmatrix(:));% allways >= -1
maxmin = abs(mini - maxi)/2;% allways between 0 and 1

nb_contours = 12;floor((1 - maxmin)*9);
%[C, h] = contourf('v6',ts,ps,-Cmatrix,-[LevelRC LevelRC]); 
[C, h] = contourf(ts,ps,-Cmatrix,-[LevelRC LevelRC]);
contour(ts, ps, Cmatrix, nb_contours);



B = mod(bazi,90);
plot([0 0]+sampling, [B B-90],'k>','markersize',5,'linewidth',1,'MarkerFaceColor','k' )
plot([maxtime maxtime]-sampling, [B B-90],'k<','markersize',5,'linewidth',1,'MarkerFaceColor','k' )
line([dtRC(2) dtRC(2)],[-90 90],'Color',[0 0 1], 'LineWidth',1)
line([0 maxtime], [phiRC(2) phiRC(2)],'Color',[0 0 1], 'LineWidth',1)
title('Map of Correlation Coefficient','FontSize',titlefontsize);
xlabel('delay time \delta{\itt} / s', 'Fontsize',fontsize);
ylabel('fast axis \phi / N°E', 'Fontsize',fontsize)
label = ['0' sprintf('|%u',1:maxtime) 'sec'];
set(gca, 'Xtick',[0:1:maxtime], 'XtickLabel', [0:1:maxtime] ,'Ytick',[-90:30:90],'xMinorTick','on','yminorTick','on')
axis([ts(1) ts(end) -90 90])
%set(h,'FaceColor',[1 1 1]*.90,'EdgeColor','k','linestyle','-','linewidth',1)
faceobjects = get(h,'Children');
set(faceobjects,'FaceColor',[1 1 1]*.90);
set(faceobjects,'EdgeColor','k');
set(faceobjects,'linestyle','-');
set(faceobjects,'linewidth',1);



hold off
%}


%%  Silver & Chan
%{
% fast/slow seismograms
axes(axSC(1))
sumFS1 = sum(abs( corFSsc(:,1) -corFSsc(:,2)));
sumFS2 = sum(abs(-corFSsc(:,1) -corFSsc(:,2)));
if ( sumFS1 < sumFS2 )
    sig = 1;
else
    sig = -1;
end
m1 = max(abs( corFSsc(:,1)));
m2 = max(abs( corFSsc(:,2)));
plot(  t, corFSsc(:,1)/m1,'b--',    t, sig*corFSsc(:,2)/m2 ,'r-','LineWidth',1);
xlim([t(1) t(end)])
ylim([-1 1])
%title(['corrected Fast (' char([183 183]) ') & Slow(-)'],'FontSize',titlefontsize);
title(['corrected Fast (\color{blue}--\color{black}) & Slow (\color{red}-\color{black})'],'FontSize',titlefontsize);
set(gca,'Ytick' , [-1 0 1])
ylabel(optionstr,'FontSize',titlefontsize)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% corrected seismograms (in Ray-system)
axes(axSC(2))
plot(t, QTcorSC(:,1),'b--',    t, QTcorSC(:,2) ,'r-','LineWidth',1);
%title([' corrected Q(' char([183 183]) ') & T(-)'],'FontSize',titlefontsize);
title([' corrected Q (\color{blue}--\color{black}) & T (\color{red}-\color{black})'],'FontSize',titlefontsize);
xlim([t(1) t(end)])
%}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% surface Particle motion
max_NE_uncor = max( max(abs(E)),max(abs(N)) );
max_NE_corsc = max( max(abs(Esc)),max(abs(Nsc)) );
max_NE = max(max_NE_uncor,max_NE_corsc);

axes(axSC(2))

hold on
grid on

%plot(E, N, 'b--', Esc, Nsc,'r-','LineWidth',1);
plot(E/max_NE, N/max_NE, 'b--', Esc/max_NE, Nsc/max_NE,'r-','LineWidth',1.5);

xlabel('\leftarrowW - E\rightarrow', 'Fontsize',fontsize);
ylabel('\leftarrowS - N\rightarrow', 'Fontsize',fontsize);
axis equal

tmp = max([abs(xlim) abs(ylim)]);%set [0 0] to centre of plot
%set(gca, 'xlim', [-tmp tmp], 'ylim', [-tmp tmp], 'XtickLabel',[], 'YtickLabel',[])
set(gca, 'xlim',[-tmp tmp], 'ylim',[-tmp tmp])
set(gca, 'Ytick',get(gca,'Xtick'))




X = sin(bazi/180*pi)*tmp;
Y = cos(bazi/180*pi)*tmp;
plot( [-X X], [-Y Y], 'k:', 'LineWidth',1)

xlim([-1.1 1.1])
ylim([-1.1 1.1])




%text(0.03,0.99,['BAZ = ' num2str(thiseq.bazi,'%.1f') '°'], ...
%	 'Color','k','FontSize',fontsize, ...
%	 'Units','normalized', 'VerticalAlignment','top', 'HorizontalAlignment','left')
% stereo hodowave
% {
%text(0.03,0.99,['BAZ = ' num2str(thiseq.bazi,'%.1f') '°'], ...
%	 'Color',[0.6350 0.0780 0.1840],'FontSize',16, ...
%	 'FontWeight','bold', ...
%	 'Units','normalized', 'VerticalAlignment','top', 'HorizontalAlignment','left')
% }
 % %{
text(0.47,0.99,'\color{blue}before --   \color{red}after -', ...
	'FontSize',fontsize, ...
	'Units','normalized', 'VerticalAlignment','top', 'HorizontalAlignment','left')
 % %}
 
% SKS-SKKS pairs 
text(0.03,0.99,['BAZ = ' num2str(thiseq.bazi,'%.2f') '°'], ...
	 'Color','black','FontSize',14, ...
	 'Units','normalized', 'VerticalAlignment','top', 'HorizontalAlignment','left')
text(0.03,0.89,['\Delta = ' num2str(thiseq.dis,'%.2f') '°'], ...
	 'Color','black','FontSize',14, ...
	 'Units','normalized', 'VerticalAlignment','top', 'HorizontalAlignment','left')
text(0.03,0.79,['hd = ' num2str(thiseq.depth,'%.1f') 'km'], ...
	 'Color','black','FontSize',14, ...
	 'Units','normalized', 'VerticalAlignment','top', 'HorizontalAlignment','left')
if strcmp(thiseq.SplitPhase,thiseq.results.SplitPhase)
	% text(0.50,0.1,['SI = ' num2str(thiseq.results(1).SI(1),'%.3f') ' ' char(177) ' ' num2str(thiseq.results(1).SI(2),'%.3f')], ...
	% 	 'Color',[0.6350 0.0780 0.1840],'FontSize',14, ...
	% 	 'Units','normalized', 'VerticalAlignment','top', 'HorizontalAlignment','left')
	if strcmp(thiseq.results(1).Null,'Yes')
		text_obs = 'null';
	elseif strcmp(thiseq.results(1).Null,'No')
		text_obs = 'split';
	end		
%	text(0.50,0.99, [text_obs ' '  thiseq.results(1).quality], ...
%		 'Color',[0.6350 0.0780 0.1840],'FontSize',14, ...
%		 'Units','normalized', 'VerticalAlignment','top', 'HorizontalAlignment','left')		 
	% text(0.03,0.1, [text_obs ' '  thiseq.results(1).quality], ... % 'Color',[0.6350 0.0780 0.1840],'FontSize',14, ...
    %      'Color', [255 90 0]/255, 'FontSize',14, ...
	% 	 'Units','normalized', 'VerticalAlignment','top', 'HorizontalAlignment','left')		 
elseif strcmp(thiseq.SplitPhase,thiseq.results(2).SplitPhase)
	% text(0.50,0.1,['SI = ' num2str(thiseq.results(2).SI(1),'%.3f') ' ' char(177) ' ' num2str(thiseq.results(2).SI(2),'%.3f')], ...
	% 	 'Color',[0.6350 0.0780 0.1840],'FontSize',14, ...
	% 	 'Units','normalized', 'VerticalAlignment','top', 'HorizontalAlignment','left')
	if strcmp(thiseq.results(2).Null,'Yes')
		text_obs = 'null';
	elseif strcmp(thiseq.results(2).Null,'No')
		text_obs = 'split';
	end		
%	text(0.50,0.99, [text_obs ' '  thiseq.results(2).quality], ...
%		 'Color',[0.6350 0.0780 0.1840],'FontSize',14, ...
%		 'Units','normalized', 'VerticalAlignment','top', 'HorizontalAlignment','left')
	text(0.1,0.1, [text_obs ' '  thiseq.results(2).quality], ... 'Color',[0.6350 0.0780 0.1840],'FontSize',14, ...
         'Color', [255 90 0]/255, 'FontSize',14, ...
		 'Units','normalized', 'VerticalAlignment','top', 'HorizontalAlignment','left')
end

ax = gca
ax.FontSize = fontsize-1;
ax.XLabel.FontSize = fontsize;
ax.YLabel.FontSize = fontsize;

hold off



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Energy Map
% %{
axes(axSC(3))

hold on
f  = size(Ematrix);
ts = linspace(0,maxtime,f(2));
ps = linspace(-90,90,f(1));

maxi = max(abs(Ematrix(:)));
mini = min(abs(Ematrix(:)));
nb_contours = floor((1 - mini/maxi)*10);
[C, h] = contourf(ts,ps,-Ematrix,-[Level Level]);
contour(ts, ps, Ematrix, nb_contours);

B = mod(bazi,90);% backazimuth lines
plot([0 0]+sampling, [B B-90],'k>','markersize',5,'linewidth',1,'MarkerFaceColor','k' )
plot([maxtime maxtime]-sampling, [B B-90],'k<','markersize',5,'linewidth',1,'MarkerFaceColor','k' )

line([0 maxtime], [phi phi],'Color',[255 90 0]/255,'LineWidth',1)
line([dt dt],[-90 90],'Color',[255 90 0]/255,'LineWidth',1)

hold off
axis([0 maxtime -90 90])
set(gca, 'Xtick',[0:1:maxtime], 'XtickLabel', [0:1:maxtime] ,'Ytick',[-90:30:90],'xMinorTick','on','yminorTick','on')
xlabel('app. delay time \delta{\itt}_a / s', 'Fontsize',fontsize);
ylabel('app. fast polarization direction \phi_a / N°E     ', 'Fontsize',fontsize)

faceobjects = get(h,'Children');
set(faceobjects,'FaceColor',[1 1 1]*.90);
set(faceobjects,'EdgeColor','k');
set(faceobjects,'linestyle','-');
set(faceobjects,'linewidth',1);

ax = gca
ax.FontSize = fontsize-1;
ax.XLabel.FontSize = fontsize;
ax.YLabel.FontSize = fontsize;

% %}


%% plot Initial seismograms %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes(axSC(1))

t2 = (0:length(Q)-1)*sampling - extime;
xx  = [0 0 s s]*sampling;
yy  = [-1.1 -1.1 1.1 1.1];
tmp = fill(xx, yy, [1 1 1]*.90, 'EdgeColor','None'); % Selection marker

hold on
grid on

plot(t2, Q/max(abs(Q)), 'b--', t2, T/max(abs(Q)), 'r-','LineWidth',1.5)

tt = thiseq.phase.ttimes;
A  = thiseq.a-extime;
F  = thiseq.f+extime;
tt = tt(A<=tt& tt<=F); %phase arrival within selection
T  = [tt;tt];
T  = T-thiseq.a;
yy = repmat([1.1 -1.1]',size(tt));
for i=1:length(T(1,:))
	index_ttname = find( T(1,i)+thiseq.a == thiseq.phase.ttimes );
    if strcmp(thiseq.phase.Names(index_ttname),thiseq.SplitPhase)
        color_phasename = 'm';
		fs_phasename = fontsize;
		fw_phasename = 'bold';
    else
        color_phasename = 'k';
		fs_phasename = fontsize-3;
		fw_phasename = 'normal';
	end
    if strcmp(thiseq.phase.Names(index_ttname),'sSKS')
		time_offset = length(Q)*sampling * 0.008;
	else
		time_offset = length(Q)*sampling * 0.04;
	end
	text(T(1,i)-time_offset, -0.85, thiseq.phase.Names(index_ttname),...
		'Color',color_phasename, 'FontSize',fs_phasename, 'FontWeight',fw_phasename, ...
		'rotation',90, 'Tag','TTime',...
		'VerticalAlignment','top', 'HorizontalAlignment','left')
end
plot(T,yy,'k:','LineWidth',1)

% %{
text(0.75,0.99,'\color{blue}Q --    \color{red}T -', ...
	'FontSize',fontsize, ...
	'Units','normalized', 'VerticalAlignment','top', 'HorizontalAlignment','left')

text(0.03,0.99,[config.stnname '   ' thiseq.dstr], ...
	'Color',[255 90 0]/255, 'FontSize',14, 'FontWeight','bold', ...
	'Units','normalized', 'VerticalAlignment','top', 'HorizontalAlignment','left')
% %}
% LGF 1. WB
% text(0.03,0.99,[config.stnname '   ' thiseq.dstr], ...
	% 'Color',[0.6350 0.0780 0.1840],'FontSize',18, ...
	% 'FontWeight','bold', ...
	% 'Units','normalized', 'VerticalAlignment','top', 'HorizontalAlignment','left')
% stereo wavehodo
%text(0.03,0.99,[thiseq.dstr], ...
%	'Color',[0.6350 0.0780 0.1840],'FontSize',16, ...
%	'FontWeight','bold', ...
%	'Units','normalized', 'VerticalAlignment','top', 'HorizontalAlignment','left')
text(0.03,0.09,['[' num2str(thiseq.filter(1), '%.3f') ',' num2str(thiseq.filter(2), '%.3f') '] Hz'], ...
	'Color','k','FontSize',14, ...
	'Units','normalized', 'VerticalAlignment','top', 'HorizontalAlignment','left')


xlim([t2(1) t2(end)])
ylim([-1.1 1.1])
yy = [ylim fliplr(ylim)];
set(tmp,'yData',yy)

xlabel('time / s', 'Fontsize',fontsize)
ylabel('normalized amplitude', 'Fontsize',fontsize)

ax = gca
ax.FontSize = fontsize-1;
ax.XLabel.FontSize = fontsize;
ax.YLabel.FontSize = fontsize;

%% EOF %%