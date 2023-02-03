function Main
clear
close all
clc

%% Define Parameters
GUIWidth = 600;
GUIHeight = 300;

%% create tabbed GUI
% 'Position', [x y width height] X&Y of left bottom Corner of the Figure From Left Bottom Corner of the Window
hFig = figure('Menubar','none','NumberTitle','off','name','Porous Media Generator','Units','Pixel','Position', [10 10 GUIWidth GUIHeight]);
movegui(hFig, 'center') % Move Figure to the Center of the Screen
s = warning('off', 'MATLAB:uitabgroup:OldVersion');
hTabGroup = uitabgroup('Parent',hFig);
warning(s);
hTabs(1) = uitab('Parent',hTabGroup, 'Title','Start ');
hTabs(2) = uitab('Parent',hTabGroup, 'Title','Simulation Parameters ');
hTabs(3) = uitab('Parent',hTabGroup, 'Title','Porous Media ');
hTabs(4) = uitab('Parent',hTabGroup, 'Title','Gas Flow ');
hTabs(5) = uitab('Parent',hTabGroup, 'Title','Heat ');
hTabs(6) = uitab('Parent',hTabGroup, 'Title','Reaction ');
hTabs(7) = uitab('Parent',hTabGroup, 'Title','Diffusion ');
hTabs(8) = uitab('Parent',hTabGroup, 'Title','Results ');
set(hTabGroup, 'SelectedTab',hTabs(1));

%# populate tabs with UI components
% 'Position', [X Y Width Heigth] X&Y of left bottom Corner of the Object From Left Bottom Corner of the figure

%% Common Components for All Tabs
pos = [520 23 60 20];
handle.StartButton = uicontrol('Style', 'pushbutton', 'String', 'Start',...
    'Position', pos,'Callback', @Start);

    function Start(source,event)
        MyStart(handle);
    end

%% Components of Tab(1) : Start
pos = [300 130 200 100];
txt = sprintf('%s\n\n%s\n\n%s','This Program is Designed to Simulate','         Gas-Solid Reactions','a A(g) + b B(s)  <=>  c C(g) + d D(s)');
handle.AboutTextTab1 = uicontrol('Style','text','Position',pos,'String',txt,'Parent',hTabs(1));
pos = [20 50 400 20];
txt = 'Select one of the options above to start'; % It will be set later
handle.InformationTextTab1 = uicontrol('Style','text','Position',pos,'String',txt,'HorizontalAlignment','left','Parent',hTabs(1));

pos = [30 140 210 120];
handle.StartButtonGroup = uibuttongroup('visible','on','Units','Pixel','Position',pos,'Title','Simulation Options','Parent',hTabs(1));
% Create three radio buttons in the button group.
pos = [10 80 200 15];
handle.StratNewSim = uicontrol('Style','radiobutton','String','Start A New New Simulation','Units','Pixel',...
    'Position',pos,'parent',handle.StartButtonGroup,'tag','NewSim');
pos = pos-[0 30 0 0];
handle.ContinueOldSim = uicontrol('Style','radiobutton','String','Continue From a Previous Simulation','Units','Pixel',...
    'Position',pos,'parent',handle.StartButtonGroup,'tag','ContinueSim');
pos = pos-[0 30 0 0];
handle.StartOldSim0 = uicontrol('Style','radiobutton','String','Start From a Previous Settings','Units','Pixel',...
    'Position',pos,'parent',handle.StartButtonGroup,'tag','PreviousSim0');
set(handle.StartButtonGroup,'SelectedObject',[]);

pos = [20 20 60 20];
handle.OpenFileButtonTab1 = uicontrol('Style', 'pushbutton', 'String', 'Open File',...
    'Position', pos,'enable','off','parent',hTabs(1),'Callback', {@MyOpenTab1,handle});

% Initialize some button group properties.
set(handle.StartButtonGroup,'SelectionChangeFcn',{@MyStartSelectionChange,handle});

%% Functions For Tab 1 : Start

%% Components of Tab(2) : Simulation Parameters
rd = 25; % Differance Between Two Rows
tw = 160; % Width of the Text Boxes
pos0 = [20 230 tw 20];
pos = pos0;
handle.HeighttextTab2 = uicontrol('Style','text','Position',pos,'String','Height of the Simulation Area','HorizontalAlignment','left','parent',hTabs(2));
pos= pos+[tw+10 3 -80 0];
handle.HeighteditTab2 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(2));
pos = pos0 - [0 rd 0 0];
handle.WidthtextTab2 = uicontrol('Style','text','Position',pos,'String','Width of the Simulation Area','HorizontalAlignment','left','parent',hTabs(2));
pos= pos+[tw+10 3 -80 0];
handle.WidtheditTab2 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(2));
pos = pos0 - 2*[0 rd 0 0];
handle.GraintextTab2 = uicontrol('Style','text','Position',pos,'String','Grain Size','HorizontalAlignment','left','parent',hTabs(2));
pos= pos+[tw+10 3 -80 0];
handle.GraineditTab2 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(2));

% pos0 = pos0 + [280 0 0 0];
pos0 = pos0 - 3*[0 rd 0 0];
pos = pos0;
handle.MaxItertextTab2 = uicontrol('Style','text','Position',pos,'String','Number of Iterations','HorizontalAlignment','left','parent',hTabs(2));
pos= pos+[tw+10 3 -80 0];
handle.MaxItereditTab2 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(2));
pos = pos0 - [0 rd 0 0];
handle.CurrentItertextTab2 = uicontrol('Style','text','Position',pos,'String','Current Iteration''s Number','HorizontalAlignment','left','parent',hTabs(2));
pos= pos+[tw+10 3 -80 0];
handle.CurrentItereditTab2 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(2),'enable','off');
pos = pos0 - 2*[0 rd 0 0];
handle.SaveItertextTab2 = uicontrol('Style','text','Position',pos,'String','Number of Iterations to Save Data','HorizontalAlignment','left','parent',hTabs(2));
pos= pos+[tw+10 3 -80 0];
handle.SaveItereditTab2 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(2));
pos = pos0 - 3*[0 rd 0 0];
handle.CenterXtextTab2 = uicontrol('Style','text','Position',pos,'String','Obstacle''s Center X','HorizontalAlignment','left','parent',hTabs(2));
pos= pos+[tw+10 3 -80 0];
handle.CenterXeditTab2 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(2));
pos = pos0 - 4*[0 rd 0 0];
handle.CenterYtextTab2 = uicontrol('Style','text','Position',pos,'String','Obstacle''s Center Y','HorizontalAlignment','left','parent',hTabs(2));
pos= pos+[tw+10 3 -80 0];
handle.CenterYeditTab2 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(2));

pos = [260 120 300 100];
handle.SchematicdiagramAxesTab2 = axes('Parent',hTabs(2),'Units','Pixel','Position', pos);
set(gca,'xtick',[], 'xticklabel',{},'ytick',[], 'yticklabel',{})
handle = MyShowSchematicdiagramTab2(handle);

pos = [20 20 60 20];
handle.LoadButtonTab2 = uicontrol('Style', 'pushbutton', 'String', 'Load',...
    'Position', pos,'parent',hTabs(2),'Callback', {@MyLoadTab2,handle,[]});
pos = pos+[70 0 0 0];
handle.DefaultsButtonTab2 = uicontrol('Style', 'pushbutton', 'String', 'Defaults',...
    'Position', pos,'parent',hTabs(2),'Callback', {@MyDefaultsTab2,handle});
pos = pos+[70 0 0 0];
handle.ClearButtonTab2 = uicontrol('Style', 'pushbutton', 'String', 'Clear',...
    'Position', pos,'parent',hTabs(2),'Callback', {@MyClearTab2,handle});

% set(hTabGroup, 'SelectedTab',hTabs(2));
%% Functions For Tab 2 : Simulation Parameters

%% Components of Tab(3) : Porous Media
rd = 25; % Differance Between Two Rows
tw = 120; % Width of the Text Boxes
pos0 = [20 220 tw 20];
pos = pos0;
handle.PorositytextTab3 = uicontrol('Style','text','Position',pos,'String','Porosity','HorizontalAlignment','left','parent',hTabs(3));
pos= pos+[tw+10 3 -50 0];
handle.PorosityeditTab3 = uicontrol('Style','edit','Position',pos,'String','','enable','off','parent',hTabs(3));
pos = pos0 - [0 rd 0 0];
handle.TotaltextTab3 = uicontrol('Style','text','Position',pos,'String','Total Solid Particles','HorizontalAlignment','left','parent',hTabs(3));
pos= pos+[tw+10 3 -50 0];
handle.TotaleditTab3 = uicontrol('Style','edit','Position',pos,'String','','enable','off','parent',hTabs(3));
pos = pos0 - 2*[0 rd 0 0];
handle.ReactanttextTab3 = uicontrol('Style','text','Position',pos,'String','Reactant Solid Particles','HorizontalAlignment','left','parent',hTabs(3));
pos= pos+[tw+10 3 -50 0];
handle.ReactanteditTab3 = uicontrol('Style','edit','Position',pos,'String','','enable','off','parent',hTabs(3));
pos = pos0 - 3*[0 rd 0 0];
handle.ProducttextTab3 = uicontrol('Style','text','Position',pos,'String','Product Solid Particles','HorizontalAlignment','left','parent',hTabs(3));
pos= pos+[tw+10 3 -50 0];
handle.ProducteditTab3 = uicontrol('Style','edit','Position',pos,'String','','enable','off','parent',hTabs(3));
pos = pos0 - 4*[0 rd 0 0];
handle.InerttextTab3 = uicontrol('Style','text','Position',pos,'String','Inert Solid Particles','HorizontalAlignment','left','parent',hTabs(3));
pos= pos+[tw+10 3 -50 0];
handle.InerteditTab3 = uicontrol('Style','edit','Position',pos,'String','','enable','off','parent',hTabs(3));
pos = pos0 - 5*[0 rd 0 0];
handle.ObsWidthtextTab3 = uicontrol('Style','text','Position',pos,'String','Obstacle''s Width','HorizontalAlignment','left','parent',hTabs(3));
pos= pos+[tw+10 3 -50 0];
handle.ObsWidtheditTab3 = uicontrol('Style','edit','Position',pos,'String','','enable','off','parent',hTabs(3));
pos = pos0 - 4*[0 rd 0 0];
handle.ObsHeighttextTab3 = uicontrol('Style','text','Position',pos,'String','Obstacle''s Height','HorizontalAlignment','left','parent',hTabs(3));
pos= pos+[tw+10 3 -50 0];
handle.ObsHeighteditTab3 = uicontrol('Style','edit','Position',pos,'String','','enable','off','parent',hTabs(3));

pos = [260 120 300 100];
handle.SchematicdiagramAxesTab3 = axes('Parent',hTabs(3),'Units','Pixel','Position', pos);
set(gca,'xtick',[], 'xticklabel',{},'ytick',[], 'yticklabel',{})
handle = MyShowSchematicdiagramTab3(handle);

pos = [20 20 60 20];
handle.DesignButtonTab3 = uicontrol('Style', 'pushbutton', 'String', 'Design',...
    'Position', pos,'parent',hTabs(3),'Callback', {@MyDesignTab3,handle});
pos = pos+[70 0 0 0];
handle.LoadButtonTab3 = uicontrol('Style', 'pushbutton', 'String', 'Load',...
    'Position', pos,'parent',hTabs(3),'Callback', {@MyLoadTab3,handle,[]});
pos = pos+[70 0 0 0];
handle.DefaultsButtonTab3 = uicontrol('Style', 'pushbutton', 'String', 'Defaults',...
    'Position', pos,'parent',hTabs(3),'Callback', {@MyDefaultsTab3,handle});
pos = pos+[70 0 0 0];
handle.ClearButtonTab3 = uicontrol('Style', 'pushbutton', 'String', 'Clear',...
    'Position', pos,'parent',hTabs(3),'Callback', {@MyClearTab3,handle});

% set(hTabGroup, 'SelectedTab',hTabs(3));
%% Functions For Tab 3 : Porous Media

%% Components of Tab(4) : Gas Flow
rd = 30; % Differance Between Two Rows
tw = 140; % Width of the Text Boxes
pos0 = [20 220 tw 20];
pos = pos0;
handle.GasFlowRatetextTab4 = uicontrol('Style','text','Position',pos,'String','Flow Rate','HorizontalAlignment','left','parent',hTabs(4));
pos= pos+[tw+10 3 -70 0];
handle.GasFlowRateeditTab4 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(4));
pos = pos0 - [0 rd 0 0];
handle.ReactantGasConctextTab4 = uicontrol('Style','text','Position',pos,'String','Reactant Gas Concentration','HorizontalAlignment','left','parent',hTabs(4));
pos= pos+[tw+10 3 -70 0];
handle.ReactantGasConceditTab4 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(4));
pos = pos0 - 2*[0 rd 0 0];
handle.TemperaturetextTab4 = uicontrol('Style','text','Position',pos,'String','Temperature','HorizontalAlignment','left','parent',hTabs(4));
pos= pos+[tw+10 3 -70 0];
handle.TemperatureeditTab4 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(4));

pos0 = pos0 +[300 0 0 0];
pos = pos0;
handle.ViscositytextTab4 = uicontrol('Style','text','Position',pos,'String','Viscosity','HorizontalAlignment','left','parent',hTabs(4));
pos= pos+[tw+10 3 -70 0];
handle.ViscosityeditTab4 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(4));
pos = pos0 - [0 rd 0 0];
handle.GasStarttextTab4 = uicontrol('Style','text','Position',pos,'String','Gas Injection Start Time','HorizontalAlignment','left','parent',hTabs(4));
pos= pos+[tw+10 3 -70 0];
handle.GasStarteditTab4 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(4));
pos = pos0 - 2*[0 rd 0 0];
handle.GasStoptextTab4 = uicontrol('Style','text','Position',pos,'String','Gas Injection Stop Time','HorizontalAlignment','left','parent',hTabs(4));
pos= pos+[tw+10 3 -70 0];
handle.GasStopeditTab4 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(4));

pos = [20 20 60 20];
handle.DefaultsButtonTab4 = uicontrol('Style', 'pushbutton', 'String', 'Defaults',...
    'Position', pos,'parent',hTabs(4),'Callback', {@MyDefaultsTab4,handle});
pos = pos+[70 0 0 0];
handle.ClearButtonTab4 = uicontrol('Style', 'pushbutton', 'String', 'Clear',...
    'Position', pos,'parent',hTabs(4),'Callback', {@MyClearTab4,handle});

% set(hTabGroup, 'SelectedTab',hTabs(4));

%% Functions For Tab 4 : Gas Flow

%% Components of Tab(5) : Heat
pos = [15 215 420 40];
handle.HeatPanelTab5 = uibuttongroup('visible','on','Units','Pixel','Position',pos,'Title','Heating','Parent',hTabs(5));
pos = [10 5 100 20];
handle.HeatOffRadioTab5 = uicontrol('Style','radiobutton','String','Off','value',1,'Units','Pixel','Position',pos,'parent',handle.HeatPanelTab5);
pos = pos + [40 0 0 0];
handle.ConstHeatRadioTab5 = uicontrol('Style','radiobutton','String','Constant Power','Units','Pixel','Position',pos,'parent',handle.HeatPanelTab5);
pos = pos+[tw-40 0 -45 0];
handle.HeatPoweditTab5 = uicontrol('Style','edit','Position',pos,'String','','enable','off','parent',handle.HeatPanelTab5);
pos = pos+[tw-70 0 80 0];
handle.ConstTempRadioTab5 = uicontrol('Style','radiobutton','String','Constant Temperature','Units','Pixel','Position',pos,'parent',handle.HeatPanelTab5);
pos = pos+[tw-10 0 -80 0];
handle.HeatTempeditTab5 = uicontrol('Style','edit','Position',pos,'String','','enable','off','parent',handle.HeatPanelTab5);

rd = 30; % Differance Between Two Rows
tw = 140; % Width of the Text Boxes
pos0 = [70 215 tw 20];
pos = pos0 - [0 rd 0 0];
handle.HeatStarttextTab5 = uicontrol('Style','text','Position',pos,'String','Heating Start Time','HorizontalAlignment','left','parent',hTabs(5));
pos= pos+[tw-45 3 -85 0];
handle.HeatStarteditTab5 = uicontrol('Style','edit','Position',pos,'String','','enable','off','parent',hTabs(5));
pos = pos0 - 2*[0 rd 0 0];
handle.HeatStoptextTab5 = uicontrol('Style','text','Position',pos,'String','Heating Stop Time','HorizontalAlignment','left','parent',hTabs(5));
pos= pos+[tw-45 3 -85 0];
handle.HeatStopeditTab5 = uicontrol('Style','edit','Position',pos,'String','','enable','off','parent',hTabs(5));

pos0 = pos0 + [170 0 0 0];
pos = pos0 - [0 rd 0 0];
handle.HeatX1textTab5 = uicontrol('Style','text','Position',pos,'String','Heating Start Distance','HorizontalAlignment','left','parent',hTabs(5));
pos= pos+[tw-15 3 -85 0];
handle.HeatX1editTab5 = uicontrol('Style','edit','Position',pos,'String','','enable','off','parent',hTabs(5));
pos = pos0 - 2*[0 rd 0 0];
handle.HeatX2textTab5 = uicontrol('Style','text','Position',pos,'String','Heating Stop Distance','HorizontalAlignment','left','parent',hTabs(5));
pos= pos+[tw-15 3 -85 0];
handle.HeatX2editTab5 = uicontrol('Style','edit','Position',pos,'String','','enable','off','parent',hTabs(5));

pos = [20 20 60 20];
handle.DefaultsButtonTab5 = uicontrol('Style', 'pushbutton', 'String', 'Defaults',...
    'Position', pos,'parent',hTabs(5),'Callback', {@MyDefaultsTab5,handle});
pos = pos+[70 0 0 0];
handle.ClearButtonTab5 = uicontrol('Style', 'pushbutton', 'String', 'Clear',...
    'Position', pos,'parent',hTabs(5),'Callback', {@MyClearTab5,handle});

set(handle.HeatPanelTab5,'SelectionChangeFcn',{@MyHeatSelectionChangeTab5,handle});

% set(hTabGroup, 'SelectedTab',hTabs(5));

%% Functions For Tab 5 : Heat

%% Components of Tab(6) : Reaction
pos = [100 230 200 30];
txt = 'a A(g) + b B(s)  <=>  c C(g) + d D(s)';
handle.AboutTextTab6 = uicontrol('Style','text','Position',pos,'String',txt,'Parent',hTabs(6));

rd = 30; % Differance Between Two Rows
tw = 20; % Width of the Text Boxes
pos0 = [45 210 tw 20];
pos = pos0;
handle.atextTab6 = uicontrol('Style','text','Position',pos,'String','a =','HorizontalAlignment','left','parent',hTabs(6));
pos= pos+[tw+5 3 10 0];
handle.aeditTab6 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(6));
pos = pos+[tw+25 -3 10 0];
handle.btextTab6 = uicontrol('Style','text','Position',pos,'String','b =','HorizontalAlignment','left','parent',hTabs(6));
pos= pos+[tw+5 3 -10 0];
handle.beditTab6 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(6));
pos = pos+[tw+25 -3 10 0];
handle.ctextTab6 = uicontrol('Style','text','Position',pos,'String','c =','HorizontalAlignment','left','parent',hTabs(6));
pos= pos+[tw+5 3 -10 0];
handle.ceditTab6 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(6));
pos = pos+[tw+25 -3 10 0];
handle.dtextTab6 = uicontrol('Style','text','Position',pos,'String','d =','HorizontalAlignment','left','parent',hTabs(6));
pos= pos+[tw+5 3 -10 0];
handle.deditTab6 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(6));

tw = 150; % Width of the Text Boxes
pos0 = [45 240 tw 20];
pos = pos0 - 2*[0 rd 0 0];
handle.r1textTab6 = uicontrol('Style','text','Position',pos,'String','Forward Reaction Probability','HorizontalAlignment','left','parent',hTabs(6));
pos= pos+[tw+10 3 -90 0];
handle.r2editTab6 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(6));
pos = pos0 - 3*[0 rd 0 0];
handle.r2textTab6 = uicontrol('Style','text','Position',pos,'String','Backward Reaction Probability','HorizontalAlignment','left','parent',hTabs(6));
pos= pos+[tw+10 3 -90 0];
handle.r1editTab6 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(6));
pos = pos0 - 4*[0 rd 0 0];
handle.DHtextTab6 = uicontrol('Style','text','Position',pos,'String','Heat of Reaction','HorizontalAlignment','left','parent',hTabs(6));
pos= pos+[tw+10 3 -90 0];
handle.DHeditTab6 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(6));
pos = pos0 - 5*[0 rd 0 0];
handle.MolarVolumeRatiotextTab6 = uicontrol('Style','text','Position',pos,'String','Molar Volume Ratio (D/B)','HorizontalAlignment','left','parent',hTabs(6));
pos= pos+[tw+10 3 -90 0];
handle.MolarVolumeRatioeditTab6 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(6));

pos = [20 20 60 20];
handle.DefaultsButtonTab6 = uicontrol('Style', 'pushbutton', 'String', 'Defaults',...
    'Position', pos,'parent',hTabs(6),'Callback', {@MyDefaultsTab6,handle});
pos = pos+[70 0 0 0];
handle.ClearButtonTab6 = uicontrol('Style', 'pushbutton', 'String', 'Clear',...
    'Position', pos,'parent',hTabs(6),'Callback', {@MyClearTab6,handle});

% set(hTabGroup, 'SelectedTab',hTabs(6));
%% Functions For Tab 6 : Reaction

%% Components of Tab(7) : Diffusion


pos = [20 20 60 20];
handle.DefaultsButtonTab7 = uicontrol('Style', 'pushbutton', 'String', 'Defaults',...
    'Position', pos,'parent',hTabs(7),'Callback', {@MyDefaultsTab7,handle});
pos = pos+[70 0 0 0];
handle.ClearButtonTab7 = uicontrol('Style', 'pushbutton', 'String', 'Clear',...
    'Position', pos,'parent',hTabs(7),'Callback', {@MyClearTab7,handle});

% set(hTabGroup, 'SelectedTab',hTabs(7));
%% Functions For Tab 7 : Diffusion

%% Components of Tab(8) : Results

pos = [30 240 140 20];
handle.SaveAddtextTab8 = uicontrol('Style','text','Position',pos,'String','Address for saving the results','HorizontalAlignment','left','parent',hTabs(8));
pos= pos+[150 3 140 0];
handle.SaveAddeditTab8 = uicontrol('Style','edit','Position',pos,'String','','parent',hTabs(8));
pos= pos+[300 0 -230 0];
handle.BrowseButtonTab8 = uicontrol('Style','pushbutton','Position',pos,'String','Browse','parent',hTabs(8),'Callback',@MyBrowseTab8);

pos = [25 165 120 70];
handle.FigPanelTab8 = uipanel('visible','on','Units','Pixel','Position',pos,'Title','Figure Saving Format','Parent',hTabs(8));
% Create three Checkboxes in the panel
rd = 15;
pos = [10 35 200 15];
handle.FigCheckTab8 = uicontrol('Style','checkbox','String','Matlab Figure (.fig)','Units','Pixel',...
    'Position',pos,'parent',handle.FigPanelTab8);
pos = pos-[0 rd 0 0];
handle.JpgCheckTab8 = uicontrol('Style','checkbox','String','JPEG Image (.jpg)','Units','Pixel',...
    'Position',pos,'parent',handle.FigPanelTab8);
pos = pos-[0 rd 0 0];
handle.TiffCheckTab8 = uicontrol('Style','checkbox','String','TIFF Image (.tif)','Units','Pixel',...
    'Position',pos,'parent',handle.FigPanelTab8);

pos = [155 130 430 105];
handle.DataPanelTab8 = uipanel('visible','on','Units','Pixel','Position',pos,'Title','Data To Save','Parent',hTabs(8));
% Create some Checkboxes in the panel
rd = 15;
pos = [10 70 200 15];
handle.ReactantGasConcCheckTab8 = uicontrol('Style','checkbox','String','Reactant Gas Concentration','Units','Pixel',...
    'Position',pos,'parent',handle.DataPanelTab8);
pos = pos-[0 rd 0 0];
handle.ProductGasConcCheckTab8 = uicontrol('Style','checkbox','String','Product Gas Concentration','Units','Pixel',...
    'Position',pos,'parent',handle.DataPanelTab8);
pos = pos-[0 rd 0 0];
handle.VelocityCheckTab8 = uicontrol('Style','checkbox','String','Velocity Vectors','Units','Pixel',...
    'Position',pos,'parent',handle.DataPanelTab8);
pos = pos-[0 rd 0 0];
handle.ReactantSolidConcCheckTab8 = uicontrol('Style','checkbox','String','Reactant Solid Concentration','Units','Pixel',...
    'Position',pos,'parent',handle.DataPanelTab8);
pos = pos-[0 rd 0 0];
handle.ProductSolidConcCheckTab8 = uicontrol('Style','checkbox','String','Product Solid Concentration','Units','Pixel',...
    'Position',pos,'parent',handle.DataPanelTab8);

pos = [175 70 200 15];
handle.ConversionCheckTab8 = uicontrol('Style','checkbox','String','Conversion','Units','Pixel',...
    'Position',pos,'parent',handle.DataPanelTab8);
pos = pos-[0 rd 0 0];
handle.TempratureCheckTab8 = uicontrol('Style','checkbox','String','Temprature','Units','Pixel',...
    'Position',pos,'parent',handle.DataPanelTab8);
pos = pos-[0 rd 0 0];
handle.PororsityCheckTab8 = uicontrol('Style','checkbox','String','Porosity','Units','Pixel',...
    'Position',pos,'parent',handle.DataPanelTab8);
pos = pos-[0 rd 0 0];
handle.InitialObsCheckTab8 = uicontrol('Style','checkbox','String','Initial Obstacle','Units','Pixel',...
    'Position',pos,'parent',handle.DataPanelTab8);
pos = pos-[0 rd 0 0];
handle.FinalObsCheckTab8 = uicontrol('Style','checkbox','String','Final Obstacle','Units','Pixel',...
    'Position',pos,'parent',handle.DataPanelTab8);

pos = [270 70 200 15];
handle.InitialSimCheckTab8 = uicontrol('Style','checkbox','String','Initial State of the Simulation','Units','Pixel',...
    'Position',pos,'parent',handle.DataPanelTab8);
pos = pos-[0 rd 0 0];
handle.FinalSimCheckTab8 = uicontrol('Style','checkbox','String','Final State of the Simulation','Units','Pixel',...
    'Position',pos,'parent',handle.DataPanelTab8);
pos = pos-[0 rd 0 0];
handle.ParametersCheckTab8 = uicontrol('Style','checkbox','String','Parameters','Units','Pixel',...
    'Position',pos,'parent',handle.DataPanelTab8);
pos = pos-[0 rd 0 0];
handle.ReactionRateCheckTab8 = uicontrol('Style','checkbox','String','Reaction Rate','Units','Pixel',...
    'Position',pos,'parent',handle.DataPanelTab8);
pos = pos-[0 rd 0 0];
handle.GasAdsorptionCheckTab8 = uicontrol('Style','checkbox','String','Gas Adsorption','Units','Pixel',...
    'Position',pos,'parent',handle.DataPanelTab8);

pos = [24 130 121 20];
handle.DefaultsButtonTab8 = uicontrol('Style', 'pushbutton', 'String', 'Select names for saving',...
    'Position', pos,'parent',hTabs(8),'Callback', {@MySaveNamesTab8,handle});

pos = [20 20 60 20];
handle.DefaultsButtonTab8 = uicontrol('Style', 'pushbutton', 'String', 'Defaults',...
    'Position', pos,'parent',hTabs(8),'Callback', {@MyDefaultsTab8,handle});
pos = pos+[70 0 0 0];
handle.ClearButtonTab8 = uicontrol('Style', 'pushbutton', 'String', 'Clear',...
    'Position', pos,'parent',hTabs(8),'Callback', {@MyClearTab8,handle});

% set(hTabGroup, 'SelectedTab',hTabs(8));

%% Functions For Tab 8 : Results
    function MyBrowseTab8(source,event)
        folder = uigetdir();
        if folder ~= 0
            set(handle.SaveAddeditTab8,'string',folder);
        end
    end
%% Components of Tab(1) : Start (Continued)
pos = [90 20 60 20];
handle.DefaultsButtonTab1 = uicontrol('Style', 'pushbutton', 'String', 'Defaults',...
    'Position', pos,'parent',hTabs(1),'Callback', {@MyDefaultsTab1,handle});
pos = pos+[70 0 0 0];
handle.ClearButtonTab1 = uicontrol('Style', 'pushbutton', 'String', 'Clear',...
    'Position', pos,'parent',hTabs(1),'Callback', {@MyClearTab1,handle});

end