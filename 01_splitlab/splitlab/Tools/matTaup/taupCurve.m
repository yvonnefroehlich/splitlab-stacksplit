function tt_curve=taupCurve(model,depth,phase)

% TAUPCURVE calculate travel time curve using TauP toolkit
%
% taupTime(model,depth,phase)
%
% Input arguments:
%   Model:      Global velocity model. Default is "iasp91".
%   Depth:      Event depth in km
%   Phase:      Phase list separated by comma
% 
% Output argumet:
%   tt is a structure array with fields:
%   tt(index).phaseName
%            .sourceDepth
%            .distance (in degree)
%            .time
%   If no output argument specified, travel timve curves will be plotted.
%
% Example:
%   taupCurve([],50,'P,sS')
%   taupCurve('prem',0,'P,PKP,PKIKP,PKiKP')
%
% This program calls TauP toolkit for calculation, which is 
% developed by:
%   H. Philip Crotwell, Thomas J. Owens, Jeroen Ritsema
%   Department of Geological Sciences
%   University of South Carolina
%   http://www.seis.sc.edu
%   crotwell@seis.sc.edu
%
% Written by:
%   Qin Li 
%   Unverisity of Washingtong 
%   qinli@u.washington.edu
%   Nov, 2002
%

import edu.sc.seis.TauP.*;
import java.io.*;
import java.lang.*;
import java.util.*;
import java.util.zip.*;

if nargin~=3
    error('3 input arguments required');
end

if isempty(model)
    model='iasp91';
end

inArgs{1}='-mod';
inArgs{2}=model;
inArgs{3}='-h';
inArgs{4}=num2str(depth);
inArgs{5}='-ph';
inArgs{6}=phase;

try
    matCurve=MatTauP_Curve.run_curve(inArgs);
catch
    fprintf('Java exception occurred! Please check input arguments. \n\n');
    return
end

tt_curve = [];
for ii=1:matCurve.length
    tt(ii).phaseName=char(matCurve(ii).phaseName);
    tt(ii).sourceDepth=matCurve(ii).sourceDepth;
    tt(ii).time=matCurve(ii).time;
    tt(ii).distance=matCurve(ii).dist;
    tt(ii).rayParam=matCurve(ii).rayParam;
end

% c_temp_01 = get(gca,'colororder')
% c = num2cell(c_temp_01',1)

% Original
% c = {'b','r','g','m','c','y', ...
%    'b:','r:','g:','m:','c:','y:', ...
%    'b--','r--','g--','m--','c--','y--', ... 
%    'b-.','r-.','g-.','m-.','c-.','y-.'};

% YF containers.Map 2024/05/05
map_phases_colors = taupColor();
map_phases_lines = taupLine();

p={};
if nargout==0
    clf;hold on;box on
    grid on
    n=0;
    for ii=1:length(tt)
        if length(tt(ii).distance)>1
            n=n+1;
            k=find(diff(tt(ii).rayParam)==0);
            temp_dist=tt(ii).distance;
            temp_time=tt(ii).time;
            if ~isempty(k) % shadow zone
                temp_dist(k)=nan;
                temp_time(k)=nan;
            end
                       
            pp(n)=plot(temp_dist, temp_time, 'LineWidth',1.5);

            color = map_phases_colors(tt(ii).phaseName);
            set(pp(n), 'color',color)

            line = map_phases_lines(tt(ii).phaseName);
            set(pp(n), 'LineStyle',line);

            p{n}=tt(ii).phaseName;
        end
    end
    
    set(pp, 'UserData',pp, 'ButtonDownFCN',@highlight)
    
    xlabel('epicentral distance / \circ');
    ylabel('travel time / s');
    
    %YF 01.05.2020
    win = [90 150];
    yy = [ylim fliplr(ylim)];
    xx = [win(1) win(1) win(2) win(2)];
    f  = fill(xx, yy, [0.8 1 0.8], 'EdgeColor','none');
    set(get(get(f,'Annotation'),'LegendInformation'),'IconDisplayStyle','off') %added to exclude from legend
    c = get(gca,'children');
    set(gca,'children',[c(2:end);c(1)],'Layer','Top','XMinorTick','on');

    % axis([60 180 1000 2400])
    
    legend(p,'location','EastOutside'); %change because of error; orginal: p,2,'location','EastOutside'

    return;
end

tt_curve=tt;




%% 
function highlight(src,evt)
disp(get(src, 'DisplayName'));
ud = get(src,'UserData');
set(ud,'LineWidth',1)
set(src,'LineWidth',2)
