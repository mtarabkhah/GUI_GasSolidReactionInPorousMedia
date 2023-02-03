function handle = MyHeatSelectionChangeTab5(source,event,handle)

if get(handle.ConstHeatRadioTab5,'value') == 1
    set(handle.HeatPoweditTab5,'enable','on');
    set(handle.HeatTempeditTab5,'enable','off');
    set(handle.HeatStarteditTab5,'enable','on');
    set(handle.HeatStopeditTab5,'enable','on');
    set(handle.HeatX1editTab5,'enable','on');
    set(handle.HeatX2editTab5,'enable','on');
elseif get(handle.ConstTempRadioTab5,'value') == 1
    set(handle.HeatPoweditTab5,'enable','off');
    set(handle.HeatTempeditTab5,'enable','on');
    set(handle.HeatStarteditTab5,'enable','on');
    set(handle.HeatStopeditTab5,'enable','on');
    set(handle.HeatX1editTab5,'enable','on');
    set(handle.HeatX2editTab5,'enable','on');
else
    set(handle.HeatPoweditTab5,'enable','off');
    set(handle.HeatTempeditTab5,'enable','off');
    set(handle.HeatStarteditTab5,'enable','off');
    set(handle.HeatStopeditTab5,'enable','off');
    set(handle.HeatX1editTab5,'enable','off');
    set(handle.HeatX2editTab5,'enable','off');
end