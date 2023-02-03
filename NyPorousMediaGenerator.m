function NyPorousMediaGenerator()

% Define Parameters
GUIWidth = 600;
GUIHeight = 300;
MenuHeight = 30;
LoadButtonWidth = 80;
LoadButtonHeight = 20;
handle.ImageData = [];
handle.FinalData = [];
handle.MatData = [];
handle.ScaleData = [];
handle.BuildData = [];
handle.BuildInput = [];

%# create tabbed GUI
% 'Position', [x y width height] X&Y of left bottom Corner of the Figure From Left Bottom Corner of the Window
hFig = figure('Menubar','none','NumberTitle','off','name','Porous Media Generator','Units','Pixel','Position', [10 10 GUIWidth GUIHeight]);
movegui(hFig, 'center') % Move Figure to the Center of the Screen
s = warning('off', 'MATLAB:uitabgroup:OldVersion');
hTabGroup = uitabgroup('Parent',hFig);
warning(s);
hTabs(1) = uitab('Parent',hTabGroup, 'Title','Build');
hTabs(2) = uitab('Parent',hTabGroup, 'Title','Convert');
hTabs(3) = uitab('Parent',hTabGroup, 'Title','Load');
hTabs(4) = uitab('Parent',hTabGroup, 'Title','Calculate');
hTabs(5) = uitab('Parent',hTabGroup, 'Title','Scale');
hTabs(6) = uitab('Parent',hTabGroup, 'Title','Save');
set(hTabGroup, 'SelectedTab',hTabs(1));

%# populate tabs with UI components
% 'Position', [X Y Width Heigth] X&Y of left bottom Corner of the Object From Left Bottom Corner of the figure
%  % Components of Tab(1) : Build
Y = GUIHeight-LoadButtonHeight-MenuHeight;
Pos = [GUIWidth-LoadButtonWidth-10 Y+25 LoadButtonWidth LoadButtonHeight];
uicontrol('Style','pushbutton', 'String','Reset', ...
    'Position', Pos,'Parent',hTabs(1), 'Callback',@ResetButtonCallback);
% Create the button group.
pos = [10 50 130 GUIHeight-120];
handle.PMButtonGroup = uibuttongroup('visible','off','Units','Pixel','Position',pos,'Parent',hTabs(1));
% Create three radio buttons in the button group.
pos = [10 160 100 15];
handle.StraitTubelar = uicontrol('Style','radiobutton','String','Strait Tubelar','Units','Pixel',...
    'Position',pos,'parent',handle.PMButtonGroup,'tag','Strait');%,'HandleVisibility','off');
pos = pos-[0 30 0 0];
handle.SineTubelar = uicontrol('Style','radiobutton','String','Sine Tubelar','Units','Pixel',...
    'Position',pos,'parent',handle.PMButtonGroup,'tag','Sine');%,'HandleVisibility','off');
pos = pos-[0 30 0 0];
handle.Cubic = uicontrol('Style','radiobutton','String','Cubic','Units','Pixel',...
    'Position',pos,'parent',handle.PMButtonGroup,'tag','Cubic');%,'HandleVisibility','off');
pos = pos-[0 30 0 0];
handle.Circular = uicontrol('Style','radiobutton','String','Circular','Units','Pixel',...
    'Position',pos,'parent',handle.PMButtonGroup,'tag','Circular');%,'HandleVisibility','off');
pos = pos-[0 30 0 0];
handle.RandCubic = uicontrol('Style','radiobutton','String','Random Cubic','Units','Pixel',...
    'Position',pos,'parent',handle.PMButtonGroup,'tag','RandCubic');%,'HandleVisibility','off');
pos = pos-[0 30 0 0];
handle.RandCircular = uicontrol('Style','radiobutton','String','Random Circular','Units','Pixel',...
    'Position',pos,'parent',handle.PMButtonGroup,'tag','RandCircular');%,'HandleVisibility','off');
% Initialize some button group properties. 
set(handle.PMButtonGroup,'SelectionChangeFcn',{@NyPMSelectionChange,handle});
set(handle.PMButtonGroup,'SelectedObject',[]); % 'SelectedObject',handle.StraitTubelar
set(handle.PMButtonGroup,'Visible','on');

pos = [150 50 130 GUIHeight-150];
handle.BuildSettingsText = uicontrol('style','text','Units','Pixel','Position',pos,'Parent',hTabs(1),'string','No Input Settings');

X = 180;
Pos = [X-5 50 LoadButtonWidth LoadButtonHeight];
handle.BuildButton = uicontrol('Style','pushbutton', 'String','Build', ...
    'Position', Pos,'Parent',hTabs(1),'enable','off',...
    'Callback',@BuildButtonCallback);
set(handle.BuildButton,'visible','off'); %%% Remember To Delete BuildButton
width = min(Y-10,GUIWidth/2-10);
Pos = [(GUIWidth)/2 10 width+10 width+10];
handle.BuildAxes = axes('Parent',hTabs(1),'Units','Pixel','Position', Pos);
set(gca,'xtick',[], 'xticklabel',{},'ytick',[], 'yticklabel',{})

%  % Components of Tab(2) : Convert
Y = GUIHeight-LoadButtonHeight-MenuHeight;
Pos = [GUIWidth-LoadButtonWidth-10 Y+25 LoadButtonWidth LoadButtonHeight];
uicontrol('Style','pushbutton', 'String','Reset', ...
    'Position', Pos,'Parent',hTabs(2), 'Callback',@ResetButtonCallback);
Y = GUIHeight-LoadButtonHeight-MenuHeight;
width = min(Y-10,GUIWidth/2-10);
Pos = [width/2 Y LoadButtonWidth LoadButtonHeight];
uicontrol('Style','pushbutton', 'String','Load Image', ...
    'Position', Pos,'Parent',hTabs(2), 'Callback',@ImageloadButtonCallback);
Pos2 = [30 10 width width];
handle.ConvertAxes1 = axes('Parent',hTabs(2),'Units','Pixel','Position', Pos2);
% cla(handle.ConvertAxes1);
set(gca,'xtick',[], 'xticklabel',{},'ytick',[], 'yticklabel',{})
Pos3 = [GUIWidth-width-30 10 width width];
handle.ConvertAxes2 = axes('Parent',hTabs(2),'Units','Pixel','Position', Pos3);
set(gca,'xtick',[], 'xticklabel',{},'ytick',[], 'yticklabel',{})
Pos = [GUIWidth-width+LoadButtonWidth+50 Y LoadButtonWidth LoadButtonHeight];
handle.Inverse = uicontrol('Style', 'checkbox','Value',0,'Enable','off',...
        'Position', Pos,'String','Inverse','Parent',hTabs(2),...
        'String','Inverse','Callback', @InverseChange); 
Pos = [GUIWidth-width+40 Y LoadButtonWidth LoadButtonHeight];
handle.Slider = uicontrol('Style', 'Slider','Min',1,'Max',255,'Value',127,...
        'Position', Pos,'Parent',hTabs(2),'Enable','off',...
        'String','Sensivity','Callback', @SliderValueChange);
Pos = [GUIWidth-width-10 Y 45 LoadButtonHeight];
uicontrol('Style','text','Units','Pixel',...
        'Position', Pos,'Parent',hTabs(2),'String','Sensivity');

%  % Components of Tab(3) : Load
Y = GUIHeight-LoadButtonHeight-MenuHeight;
Pos = [GUIWidth-LoadButtonWidth-10 Y+25 LoadButtonWidth LoadButtonHeight];
uicontrol('Style','pushbutton', 'String','Reset', ...
    'Position', Pos,'Parent',hTabs(3), 'Callback',@ResetButtonCallback);
Pos = [10 GUIHeight-LoadButtonHeight-MenuHeight LoadButtonWidth LoadButtonHeight];
uicontrol('Style','pushbutton', 'String','Load Mat File', ...
    'Position', Pos,'Parent',hTabs(3), 'Callback',@MatloadButtonCallback);
Pos = [10 GUIHeight-LoadButtonHeight-MenuHeight-LoadButtonHeight-10 LoadButtonWidth LoadButtonHeight];
uicontrol('Style','pushbutton', 'String','Inverse', ...
    'Position', Pos,'Parent',hTabs(3), 'Callback',@MatInverseButtonCallback);
handle.LoadAxes = axes('Parent',hTabs(3));
set(gca,'xtick',[], 'xticklabel',{},'ytick',[], 'yticklabel',{},'Box','off')

%  % Components of Tab(4) : Calculate
Y = GUIHeight-LoadButtonHeight-MenuHeight;
Pos = [GUIWidth-LoadButtonWidth-10 Y+25 LoadButtonWidth LoadButtonHeight];
uicontrol('Style','pushbutton', 'String','Reset', ...
    'Position', Pos,'Parent',hTabs(4), 'Callback',@ResetButtonCallback);
Pos = [10 GUIHeight-70 LoadButtonWidth LoadButtonHeight];
handle.PorCheckbox = uicontrol('Style','checkbox', 'String','Porosity','Value',1, ...
    'Position', Pos,'Parent',hTabs(4));
Pos = [LoadButtonWidth+20 GUIHeight-70 LoadButtonWidth LoadButtonHeight];
handle.CalculatePorosity = uicontrol('Style','edit','BackGroundColor',[1 1 1],'String','','Enable','off',...
    'Units','Pixel','Position',Pos,'Parent',hTabs(4));
Pos = [10 GUIHeight-150 LoadButtonWidth LoadButtonHeight];
handle.TorCheckbox = uicontrol('Style','checkbox', 'String','Tortuosity','Value',1, ...
    'Position', Pos,'Parent',hTabs(4));
Pos = [LoadButtonWidth+20 GUIHeight-150 LoadButtonWidth LoadButtonHeight];
handle.CalculateTortuosity = uicontrol('Style','edit','BackGroundColor',[1 1 1],'String','','Enable','off',...
    'Units','Pixel','Position',Pos,'Parent',hTabs(4));
Pos = [10 50 LoadButtonWidth LoadButtonHeight];
handle.CalculateButton = uicontrol('Style','pushbutton', 'String','Calculate', ...
    'Position', Pos,'Parent',hTabs(4),...
    'Enable','off','Callback',@CalculateButtonCallback);
Pos = [(GUIWidth)/2-30 10 width+10 width+10];
handle.CalculateAxes = axes('Parent',hTabs(4),'Units','Pixel','Position', Pos);
set(gca,'xtick',[], 'xticklabel',{},'ytick',[], 'yticklabel',{})

%  % Components of Tab(5) : Scale
Y = GUIHeight-LoadButtonHeight-MenuHeight;
Pos = [GUIWidth-LoadButtonWidth-10 Y+25 LoadButtonWidth LoadButtonHeight];
uicontrol('Style','pushbutton', 'String','Reset', ...
    'Position', Pos,'Parent',hTabs(5), 'Callback',@ResetButtonCallback);
Y = GUIHeight-LoadButtonHeight-MenuHeight;
width = min(Y-10,GUIWidth/2-10);
Pos = [width/4+LoadButtonWidth-10 Y 30 LoadButtonHeight];
handle.OldX = uicontrol('Style','edit','BackGroundColor',[1 1 1], 'String','','Enable','off',...
    'Units','Pixel','Position', Pos,'Parent',hTabs(5));
Pos = [width/4+LoadButtonWidth+30 Y 30 LoadButtonHeight];
handle.OldY = uicontrol('Style','edit','BackGroundColor',[1 1 1], 'String','','Enable','off',...
    'Units','Pixel','Position', Pos,'Parent',hTabs(5));
Pos = [width/4+LoadButtonWidth+20 Y 10 LoadButtonHeight];
uicontrol('Style','text', 'String','x', ...
    'Units','Pixel','Position', Pos,'Parent',hTabs(5));
Pos = [width/4 Y LoadButtonWidth-10 LoadButtonHeight];
uicontrol('Style','text', 'String','Current Size :', ...
    'Units','Pixel','Position', Pos,'Parent',hTabs(5));
Pos = [GUIWidth-width+LoadButtonWidth-10 Y 30 LoadButtonHeight];
handle.NewX = uicontrol('Style','edit','BackGroundColor',[1 1 1], 'String','', ...
    'Units','Pixel','Position', Pos,'Parent',hTabs(5));
Pos = [GUIWidth-width+LoadButtonWidth+30 Y 30 LoadButtonHeight];
handle.NewY = uicontrol('Style','edit','BackGroundColor',[1 1 1], 'String','', ...
    'Units','Pixel','Position', Pos,'Parent',hTabs(5));
Pos = [GUIWidth-width+LoadButtonWidth+20 Y 10 LoadButtonHeight];
uicontrol('Style','text', 'String','x', ...
    'Units','Pixel','Position', Pos,'Parent',hTabs(5));
Pos = [GUIWidth-width Y LoadButtonWidth-10 LoadButtonHeight];
uicontrol('Style','text', 'String','New Size :', ...
    'Units','Pixel','Position', Pos,'Parent',hTabs(5));
Pos = [width Y LoadButtonWidth LoadButtonHeight];
handle.ScaleButton = uicontrol('Style','pushbutton', 'String','Scale Image', ...
    'Units','Pixel','Position', Pos,'Parent',hTabs(5),...
    'Enable','off','Callback',@ScaleButtonCallback);
Pos2 = [30 10 width width];
handle.ScaleAxes1 = axes('Parent',hTabs(5),'Units','Pixel','Position', Pos2);
set(gca,'xtick',[], 'xticklabel',{},'ytick',[], 'yticklabel',{})
Pos3 = [GUIWidth-width-30 10 width width];
handle.ScaleAxes2 = axes('Parent',hTabs(5),'Units','Pixel','Position', Pos3);
set(gca,'xtick',[], 'xticklabel',{},'ytick',[], 'yticklabel',{})

%  % Components of Tab(6) : Save
Y = GUIHeight-LoadButtonHeight-MenuHeight;
Pos = [GUIWidth-LoadButtonWidth-10 Y+25 LoadButtonWidth LoadButtonHeight];
uicontrol('Style','pushbutton', 'String','Reset', ...
    'Position', Pos,'Parent',hTabs(6), 'Callback',@ResetButtonCallback);
Pos = [(GUIWidth)/2-30 10 width+10 width+10];
handle.SaveAxes = axes('Parent',hTabs(6),'Units','Pixel','Position', Pos);
set(gca,'xtick',[], 'xticklabel',{},'ytick',[], 'yticklabel',{})
Pos = [20 Y-10 LoadButtonWidth-20 LoadButtonHeight];
uicontrol('Style','text', 'String','Porosity :','HorizontalAlignment','Left', ...
    'Units','Pixel','Position', Pos,'Parent',hTabs(6));
Pos = [LoadButtonWidth+7 Y-8 75 LoadButtonHeight];
handle.SavePorosity = uicontrol('Style','edit','BackGroundColor',[1 1 1],'String','','Enable','off',...
    'Units','Pixel','Position',Pos,'Parent',hTabs(6));
Pos = [20 Y-LoadButtonHeight-20 LoadButtonWidth-20 LoadButtonHeight];
uicontrol('Style','text', 'String','Tortuosity :','HorizontalAlignment','Left',...
    'Units','Pixel','Position', Pos,'Parent',hTabs(6));
Pos = [LoadButtonWidth+7 Y-LoadButtonHeight-18 75 LoadButtonHeight];
handle.SaveTortuosity = uicontrol('Style','edit','BackGroundColor',[1 1 1],'String','','Enable','off',...
    'Units','Pixel','Position',Pos,'Parent',hTabs(6));
Pos = [20 Y-2*LoadButtonHeight-30 LoadButtonWidth-18 LoadButtonHeight];
uicontrol('Style','text', 'String','Dimensions :','HorizontalAlignment','Left',...
    'Units','Pixel','Position', Pos,'Parent',hTabs(6));
Pos = [LoadButtonWidth+7 Y-2*LoadButtonHeight-28 30 LoadButtonHeight];
handle.SaveDimX = uicontrol('Style','edit','BackGroundColor',[1 1 1],'String','','Enable','off',...
    'Units','Pixel','Position',Pos,'Parent',hTabs(6));
Pos = [LoadButtonWidth+40 Y-2*LoadButtonHeight-30 10 LoadButtonHeight];
uicontrol('Style','text', 'String','x','HorizontalAlignment','Left',...
    'Units','Pixel','Position', Pos,'Parent',hTabs(6));
Pos = [LoadButtonWidth+52 Y-2*LoadButtonHeight-28 30 LoadButtonHeight];
handle.SaveDimY = uicontrol('Style','edit','BackGroundColor',[1 1 1],'String','','Enable','off',...
    'Units','Pixel','Position',Pos,'Parent',hTabs(6));
Pos = [20 Y-3*LoadButtonHeight-40 LoadButtonWidth-20 LoadButtonHeight];
uicontrol('Style','text', 'String','Name :','HorizontalAlignment','Left',...
    'Units','Pixel','Position', Pos,'Parent',hTabs(6));
Pos = [LoadButtonWidth+7 Y-3*LoadButtonHeight-38 75 LoadButtonHeight];
handle.SaveName = uicontrol('Style','edit','BackGroundColor',[1 1 1],'String','',...
    'Units','Pixel','Position',Pos,'Parent',hTabs(6), 'Callback',@SaveNameCallback);

Pos = [50 Y-4*LoadButtonHeight-50 LoadButtonWidth LoadButtonHeight];
handle.SaveButton = uicontrol('Style','pushbutton', 'String','Save','Enable','off', ...
    'Units','Pixel','Position', Pos,'Parent',hTabs(6), 'Callback',@SaveButtonCallback);


%# button callback
% Button Callback Functions Can be Defined Here or Other m-file

    function ResetButtonCallback(src,evt)
        handle = ResetButtonCallback2(handle);
    end

    function BuildButtonCallback(src,evt)
        handle = BuildButtonCallback2(handle);
    end

%     function PMSelectionChange(src,evt)
%         handle = PMSelectionChange2(handle);
%     end

    function ImageloadButtonCallback(src,evt)
        handle = ImageloadButtonCallback2(handle);
    end

    function SliderValueChange(src,evt)
        handle = Convert(handle);
    end

    function InverseChange(src,evt)
        handle = Convert(handle);
    end

    function MatloadButtonCallback(src,evt)
        handle = MatloadButtonCallback2(handle);
    end

    function MatInverseButtonCallback(src,evt)
        handle = MatInverseButtonCallback2(handle);
    end

    function CalculateButtonCallback(src,evt)
        CalculateButtonCallback2(handle);
    end

    function ScaleButtonCallback(src,evt)
        NX = str2num(get(handle.NewX,'String'));
        NY = str2num(get(handle.NewY,'String'));
        if ~(isempty(NX)||isempty(NY))
            handle = ScaleButtonCallback2(NX,NY,handle);
        end
    end

    function SaveNameCallback(src,evt)
        SaveNameCallback2(handle);
    end


    function SaveButtonCallback(src,evt)
        SaveButtonCallback2(handle);
    end

end