function MyOpenTab1(source,event,handle)
[file,path] = uigetfile('*.mat');
if file ~= 0
    %     if get(handle.ContinueOldSim,'value') == 1
    %         txt = 'Now Press Start or go through other tabs to change the simulation parameters';
    %         set(handle.StartButton,'string','Continue');
    %         set(handle.StartButton,'enable','on');
    %     else
    %         txt = 'Now Press Start or go through other tabs to set the remaining simulation parameters';
    %         set(handle.StartButton,'string','Start');
    %         set(handle.StartButton,'enable','on');
    %     end
    txt = 'Now Press Start or go through other tabs to change the simulation parameters';
    set(handle.InformationTextTab1,'String',txt);
end