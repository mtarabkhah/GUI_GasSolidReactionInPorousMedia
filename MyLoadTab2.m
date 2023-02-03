function MyLoadTab2(source,event,handle,add)
if isempty(add)
    [file,path] = uigetfile('*.mat');
    if file ~= 0
        add = [path,file];
    else
        return
    end
end
    load(add);
    contourf(handle.SchematicdiagramAxesTab2,obstacle,'Linestyle','none')
    axis(handle.SchematicdiagramAxesTab2,'equal');
    axis(handle.SchematicdiagramAxesTab2,'off');
end