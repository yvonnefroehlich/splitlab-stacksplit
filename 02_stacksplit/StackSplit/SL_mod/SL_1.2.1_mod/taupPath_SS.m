function tt_path=taupPath(model,depth,phase,varargin)

% TAUPPATH calculate ray path using TauP toolkit
%
% tt_path=taupPath(model,depth,phase,'option',value,...)
%
% Input arguments:
% The first three arguments are fixed:
%   Model:      Global velocity model. Default is "iasp91".
%   Depth:      Event depth in km
%   Phase:      Phase list separated by comma
% The other arguments are variable:
%   'deg' value:   Epicentral distance in degree
%   'km'  value:   Epicentral distance in kilometer
%   'sta'/'station' value:  Station location [Lat Lon]
%   'evt'/'event' value:    Event location [Lat Lon]
% 
% Output argument:
%   tt_path is a structure array with fields:
%   tt_path(index).time
%            .distance
%            .srcDepth
%            .rayParam
%            .phaseName
%            .path.p
%            .path.time
%            .path.distance
%            .path.depth
%            .path.latitude
%            .path.longitude
%
%   If no output argument specified, ray paths will be plotted.
%
% Example:
%   taupPath([],550,'P,sS','deg',45.6)
%   taupPath('prem',0,'Pdiff,PKP,PKIKP','sta',[-40 -100],'evt',[30,50])
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

if nargin<5
    error('At least 5 input arguments required');
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
n_inArgs=6;

dist=0;
sta=0;
evt=0;
ii=1;
while (ii<=length(varargin))
    switch lower(varargin{ii})
    case {'deg','km'}
        if ~(isa(varargin{ii+1},'double') && length(varargin{ii+1})==1)
            error('  Incompatible value for option %s !',varargin{ii});
        end
        inArgs{n_inArgs+1}=['-' varargin{ii}];
        inArgs{n_inArgs+2}=num2str(varargin{ii+1});
        n_inArgs=n_inArgs+2;
        ii=ii+2;
        dist=1;
    case {'sta','station'}
        if ~(isa(varargin{ii+1},'double') && length(varargin{ii+1})==2)
            error('  Incompatible value for option %s !',varargin{ii});
        end
        inArgs{n_inArgs+1}='-sta';
        temp=varargin{ii+1};
        inArgs{n_inArgs+2}=num2str(temp(1));
        inArgs{n_inArgs+3}=num2str(temp(2));
        n_inArgs=n_inArgs+3;
        ii=ii+2;
        sta=1;
    case {'evt','event'}
        if ~(isa(varargin{ii+1},'double') && length(varargin{ii+1})==2)
            error('  Incompatible value for option %s !',varargin{ii});
        end
        inArgs{n_inArgs+1}='-evt';
        temp=varargin{ii+1};
        inArgs{n_inArgs+2}=num2str(temp(1));
        inArgs{n_inArgs+3}=num2str(temp(2));
        n_inArgs=n_inArgs+3;
        ii=ii+2;
        evt=1;
    otherwise
        error('  Unknown option %s \n',varargin{ii});
    end %switch
end %for
if ~(dist | (sta & evt))
    error('  Event/source locations or distance not specified !');
end

%disp(inArgs);

try
    matArrivals=MatTauP_Path.run_path(inArgs);
catch
    fprintf('Java exception occurred! Please check input arguments. \n\n');
    return
end

if matArrivals.length==0
    fprintf('   Phases do not exist at specified distance!\n');
end

tt_path = [];
for ii=1:matArrivals.length
    tt(ii).time=matArrivals(ii).getTime;
    tt(ii).distance=matArrivals(ii).getDistDeg;
    tt(ii).srcDepth=matArrivals(ii).getSourceDepth;
    tt(ii).phaseName=char(matArrivals(ii).getName);
    tt(ii).rayParam=matArrivals(ii).getRayParam;
    tt(ii).path.p=matArrivals(ii).getMatPath.p;
    tt(ii).path.time=matArrivals(ii).getMatPath.time;
    tt(ii).path.distance=matArrivals(ii).getMatPath.dist;
    tt(ii).path.depth=matArrivals(ii).getMatPath.depth;
    tt(ii).path.latitude=matArrivals(ii).getMatPath.lat;
    tt(ii).path.longitude=matArrivals(ii).getMatPath.lon;
end

% Original
% c = {'b','r','g','m','c','y', ...
%    'b:','r:','g:','m:','c:','y:', ...
%    'b--','r--','g--','m--','c--','y--', ... 
%    'b-.','r-.','g-.','m-.','c-.','y-.'};

% YF containers.Map 2024/05/05
map_phases_colors = taupColor();
map_phases_lines = taupLine();

p={};
h=[];
if nargout==0 & matArrivals.length>0
    clf;hold on
    [cx,cy]=circle(6371);
    fill(cx,cy,[.9 .9 .9],'edgecolor','k','linewidth',2); %'w'; self changed
    [cx,cy]=circle(5961); %410 km; self added
    fill(cx,cy,[.9 .9 .9],'edgecolor',[0.5 0.5 0.5],'linewidth',1); %'w'; self changed
    [cx,cy]=circle(5711); %660 km; self added
    fill(cx,cy,'w','edgecolor',[0.5 0.5 0.5],'linewidth',1);
    [cx,cy]=circle(3730); %D'' km; self added
    fill(cx,cy,[.9 .9 .9],'edgecolor',[0.5 0.5 0.5],'linewidth',1);
    [cx,cy]=circle(3480);
    fill(cx,cy,'w','edgecolor','k','linewidth',2); %[.9 .9 .9], [0.5 0.5 0.5]; self changed
    [cx,cy]=circle(1220);
    fill(cx,cy,'w','edgecolor','k','linewidth',2); %[.8 .8 .8], [0.5 0.5 0.5]; self changed
    axis off;
    axis equal;
    for ii=1:matArrivals.length %2
        fprintf('  Phase: %-10s  Time: %.3f(s) \n', ...
            char(matArrivals(ii).getName),matArrivals(ii).getTime);
        cx=(6371-tt(ii).path.depth).*sin(tt(ii).path.distance/180*pi);
        cy=(6371-tt(ii).path.depth).*cos(tt(ii).path.distance/180*pi);

        h(ii)=plot(cx,cy, 'LineWidth',1.5);

        color = map_phases_colors(tt(ii).phaseName);
        set(h(ii), 'color',color)
            
        line = map_phases_lines(tt(ii).phaseName);
        set(h(ii), 'LineStyle',line);

        plot(cx(1),cy(1),'kp','MarkerSize',17,'MarkerFaceColor',[255 90 0]/255);  % source
        plot(cx(end)+350,cy(end)-160,'kv','MarkerSize',11,'MarkerFaceColor', [255 215 0]/255);  % receiver
        p{ii}=tt(ii).phaseName;
    end
    h(ii+1) = text(cx(end),cy(end),'');
    set(h, 'UserData',h, 'ButtonDownFCN', @highlight)
 
    legend(h(1:ii), p, 'location','eastoutside'); %self changed because of Matlab error; orginal: p,2 
    
    return
    
end


tt_path=tt;


%% --------------------------------------------
function [cx,cy]=circle(r)
    ang=0:0.002:pi*2;
    cx=sin(ang)*r;
    cy=cos(ang)*r;
return

%% --------------------------------------------
function highlight(src,evt)
name = (get(src, 'DisplayName'));
ud = get(src,'UserData');
set(ud,'LineWidth',1)
set(src,'LineWidth',2)
 set(ud(end),'String',[ '  ' name])

