function [axSC] = splitdiagnosticLayout(Synfig)



m1 = uimenu(Synfig,'Label',   'Quality');
q(1) = uimenu(m1,'Label',  'good ', 'Accelerator','g','Callback',@q_callback);
q(2) = uimenu(m1,'Label',  'fair ', 'Accelerator','f','Callback',@q_callback);
q(3) = uimenu(m1,'Label',  'poor ', 'Accelerator','p','Callback',@q_callback);
%  q(4) = uimenu(m1,'Label',  'trash', 'Callback',q_callback);
set(q,'Userdata',q)

m2 = uimenu(Synfig,'Label',   'IsNull');
n(1) = uimenu(m2,'Label',  'Yes', 'Accelerator','y', 'Callback',@n_callback);
n(2) = uimenu(m2,'Label',  'No ', 'Accelerator','n', 'Callback',@n_callback);
set(n,'Userdata',n)

m3 = uimenu(Synfig,'Label',   'Result');
n(1) = uimenu(m3,'Label',  'Save',      'Accelerator','s', 'Callback','saveresult;');
n(2) = uimenu(m3,'Label',  'Discard',   'Accelerator','d', 'Callback','close(gcbf)');
n(3) = uimenu(m3,'Label',  'Add remark','Accelerator','r', 'Callback', ...
    'n=thiseq.resultnumber; thiseq.tmpresult.remark = char(inputdlg(''Enter a remark to this result'', ''Remark'',1,{thiseq.tmpresult.remark})); clear n;');
set(n(1:2),'Userdata',n(1:2))

m4 = uimenu(Synfig,'Label',   'Figure');
uimenu(m4,'Label',  'Save current figure',  'Callback',@localSavePicture);
uimenu(m4,'Label',  'Page setup',           'Callback','pagesetupdlg(gcbf)');
uimenu(m4,'Label',  'Print preview',        'Callback','printpreview(gcbf)');
uimenu(m4,'Label',  'Print current figure', 'Callback','printdlg(gcbf)');

%% create Axes


% borders
fontsize = get(gcf,'DefaultAxesFontsize');
%panel1 = uipanel('units','normalized',  'Position',[.025 .39  .96 .36],  'BackgroundColor', 'w', 'BorderType', 'line', 'HighlightColor','k');
%panel2 = uipanel('units','normalized',  'Position',[.025 .015 .96 .36],  'BackgroundColor', 'w', 'BorderType', 'line', 'HighlightColor','k');
%panel1 = uipanel('units','normalized',  'Position',[.025 .39  .96 .36],  'BackgroundColor', 'w', 'BorderType', 'line', 'HighlightColor','w');
%panel2 = uipanel('units','normalized',  'Position',[.025 .015 .96 .36],  'BackgroundColor', 'w', 'BorderType', 'line', 'HighlightColor','w');

%panel2 = uipanel('units','normalized',  'Position',[0 0 1 1],  'BackgroundColor', 'w', 'BorderType', 'line', 'HighlightColor','w');

%clf
%axSeis     = axes('Parent',gcf,'units','normalized', 'position',[.17 .78 .19 .20], 'Box','on', 'Fontsize',fontsize);
%axSeis(2)  = axes('Parent',gcf,'units','normalized', 'position',[.72 .80 .15 .16], 'Box','on', 'Fontsize',fontsize);

%axRC(1) = axes('Parent',panel1,'units','normalized', 'position',[.14 .16 .17 .70], 'Box','on', 'Fontsize',fontsize);
%axRC(2) = axes('Parent',panel1,'units','normalized', 'position',[.34 .16 .17 .70], 'Box','on', 'Fontsize',fontsize);
%axRC(3) = axes('Parent',panel1,'units','normalized', 'position',[.51 .16 .17 .70], 'Box','on', 'Fontsize',fontsize);
%axRC(4) = axes('Parent',panel1,'units','normalized', 'position',[.70 .16 .17 .70], 'Box','on', 'Fontsize',fontsize,'Layer','top');


% paper BFO
% Fig 2
% normalized
%axSC(1) = axes('units','normalized', 'position',[.040 0.12 .34 .85], 'Box','on', 'Fontsize',fontsize);
%axSC(2) = axes('units','normalized', 'position',[.420 0.12 .26 .85], 'Box','on', 'Fontsize',fontsize);
%axSC(3) = axes('units','normalized', 'position',[.725 0.12 .25 .85], 'Box','on', 'Fontsize',fontsize);

axSC(1) = axes('units','normalized', 'position',[.050 0.15 .32 .75], 'Box','on', 'Fontsize',fontsize);
axSC(2) = axes('units','normalized', 'position',[.430 0.10 .24 .85], 'Box','on', 'Fontsize',fontsize);
axSC(3) = axes('units','normalized', 'position',[.735 0.15 .23 .75], 'Box','on', 'Fontsize',fontsize);

% centimeter
%axSC(1) = axes('units','centimeters', 'position',[ 2 1.50 13 8], 'Box','on', 'Fontsize',fontsize);
%axSC(2) = axes('units','centimeters', 'position',[17 2.00  7 7], 'Box','on', 'Fontsize',fontsize);
%axSC(3) = axes('units','centimeters', 'position',[26 2.00  7 7], 'Box','on', 'Fontsize',fontsize);

% Fig 3
% normalized
%axSC(1) = axes('units','normalized', 'position',[.050 0.12 .34 .85], 'Box','on', 'Fontsize',fontsize);
%axSC(2) = axes('units','normalized', 'position',[.415 0.12 .26 .85], 'Box','on', 'Fontsize',fontsize);

%axSC(2) = axes('units','normalized', 'position',[.050 0.12 .26 .85], 'Box','on', 'Fontsize',fontsize);
%axSC(1) = axes('units','normalized', 'position',[.360 0.12 .34 .85], 'Box','on', 'Fontsize',fontsize);

% centimeter
%axSC(1) = axes('units','centimeters', 'position',[ 2 1.5 14.0 8.0], 'Box','on', 'Fontsize',fontsize); % [left bottom width height]
%axSC(2) = axes('units','centimeters', 'position',[18 1.5  8.0 8.0], 'Box','on', 'Fontsize',fontsize);

%axSC(2) = axes('units','centimeters', 'position',[ 2 1.5  8.0 8.0], 'Box','on', 'Fontsize',fontsize);
%axSC(1) = axes('units','centimeters', 'position',[12 1.5 14.0 8.0], 'Box','on', 'Fontsize',fontsize);






% header axes:
%axH    = axes('Parent',gcf,'units','normalized',  'Position',[.33 .8 .46 .14]);
%axis off



%% SUBFUNTION menu


%% ---------------------------------
function q_callback(src,evt)
% quality menu callback
global thiseq
% 1) set menu markers
tmp1 = get(src,'Userdata');
set(tmp1(tmp1~=src),'Checked','off');
set(src,'Checked','on'),
thiseq.Q=get(src,'Label');


% 2) set figure header entries
tmp1 = findobj('Tag','FigureHeader');
tmp2 = get(tmp1,'String');
tmp3 = tmp2{end};
tmp3(29:33)=thiseq.Q;
tmp2(end) = {tmp3};
set(tmp1,'String',tmp2);

%% ---------------------------------
function n_callback(src,evt)
%null menu callback
global thiseq
% 1) set menu markers
tmp1 = get(src,'Userdata');
set(tmp1(tmp1~=gcbo),'Checked','off');
set(gcbo,'Checked','on')
thiseq.AnisoNull=get(gcbo,'Label');

% 2) set figure header entries
tmp1 = findobj('Tag','FigureHeader');
tmp2 = get(tmp1,'String');
tmp3 = tmp2{end};
tmp3(52:54) = thiseq.AnisoNull;
tmp2(end) = {tmp3};
set(tmp1,'String',tmp2);

%% xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
function localSavePicture(hFig,evt)
global config thiseq
defaultname = sprintf('%s_%4.0f.%03.0f.%02.0f.result_%s_redSC.',config.stnname,thiseq.date([1 7 4]),thiseq.SplitPhase);
defaultextension = strrep(config.exportformat,'.','');
%exportfiguredlg(gcbf, [defaultname defaultextension])
exportgraphics(gcbf,[defaultname 'png'],'Resolution',360)
exportgraphics(gcbf,[defaultname 'eps'],'ContentType','vector')
exportgraphics(gcbf,[defaultname 'pdf'],'ContentType','vector')
