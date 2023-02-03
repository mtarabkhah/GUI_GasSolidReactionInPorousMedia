function handle = MyDefaultsTab5(source,event,handle)

set(handle.HeatPoweditTab5,'string','100');
set(handle.HeatStarteditTab5,'string','1');
set(handle.HeatStopeditTab5,'string',get(handle.MaxItereditTab2,'string'));

set(handle.ConstHeatRadioTab5,'value',1);
set(handle.HeatPoweditTab5,'enable','on');
set(handle.HeatTempeditTab5,'enable','off');
set(handle.HeatStarteditTab5,'enable','on');
set(handle.HeatStopeditTab5,'enable','on');
set(handle.HeatX1editTab5,'enable','on');
set(handle.HeatX2editTab5,'enable','on');
set(handle.HeatPoweditTab5,'string','100');
set(handle.HeatTempeditTab5,'string','');
set(handle.HeatStarteditTab5,'string','1');
set(handle.HeatStopeditTab5,'string',get(handle.MaxItereditTab2,'string'));
set(handle.HeatX1editTab5,'string','70');
set(handle.HeatX2editTab5,'string','220');
