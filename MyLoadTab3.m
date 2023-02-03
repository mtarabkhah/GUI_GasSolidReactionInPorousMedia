function MyLoadTab3(source,event,handle,add)
if isempty(add)
    [file,path] = uigetfile('*.mat');
    if file ~= 0
        add = [path,file];
    else
        return
    end
end
    load(add);
    contourf(handle.SchematicdiagramAxesTab3,obstacle,'Linestyle','none')
    axis(handle.SchematicdiagramAxesTab3,'equal');
    axis(handle.SchematicdiagramAxesTab3,'off');
end