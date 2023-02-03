function handle = MyDefaultsTab1(source,event,handle)

set(handle.StartOldSim0,'value',1);
txt = 'Now Press Start or go through other tabs to set the remaining simulation parameters';
set(handle.InformationTextTab1,'String',txt);
% set(handle.StartButton,'string','Start');
% set(handle.StartButton,'enable','on');
handle = MyDefaultsTab2(source,event,handle);
handle = MyDefaultsTab3(source,event,handle);
handle = MyDefaultsTab4(source,event,handle);
handle = MyDefaultsTab5(source,event,handle);
handle = MyDefaultsTab6(source,event,handle);
handle = MyDefaultsTab7(source,event,handle);
handle = MyDefaultsTab8(source,event,handle);