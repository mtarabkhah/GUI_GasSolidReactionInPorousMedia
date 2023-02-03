function handle = MyStartSelectionChange(source,event,handle)
switch get(get(handle.StartButtonGroup,'SelectedObject'),'tag')
    case 'NewSim'
        set(handle.OpenFileButtonTab1,'enable','off');
        txt = 'Now go through other tabs to set the simulation parameters';
    case 'ContinueSim'
        set(handle.OpenFileButtonTab1,'enable','on');
        txt = 'Press "Open File" button below to select your data file';
    case 'PreviousSim0'
        set(handle.OpenFileButtonTab1,'enable','on');
        txt = 'Press "Open File" button below to select your data file';
end
set(handle.InformationTextTab1,'String',txt);
