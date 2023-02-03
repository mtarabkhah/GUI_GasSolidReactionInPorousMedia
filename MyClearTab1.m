function handle = MyClearTab1(source,event,handle)

set(handle.StartButtonGroup,'SelectedObject',[]);
set(handle.OpenFileButtonTab1,'enable','off');
txt = 'Select one of the options above to start';
set(handle.InformationTextTab1,'String',txt);
% set(handle.StartButton,'enable','off');
% set(handle.StartButton,'string','Start');
handle = MyClearTab2(source,event,handle);
handle = MyClearTab3(source,event,handle);
handle = MyClearTab4(source,event,handle);
handle = MyClearTab5(source,event,handle);
handle = MyClearTab6(source,event,handle);
handle = MyClearTab7(source,event,handle);
handle = MyClearTab8(source,event,handle);