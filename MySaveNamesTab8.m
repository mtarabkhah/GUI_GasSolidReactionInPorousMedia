function handle = MySaveNamesTab8(source,event,handle)
title='Name for saving data';
prompt = {};
defaults = {};
i = 0;
if get(handle.ReactantGasConcCheckTab8,'value') == 1
    i = i+1;
    prompt{i}='Reactant Gas Concentration :';
    defaults{i}='ReactantGasConcentration';
end
if get(handle.ProductGasConcCheckTab8,'value') == 1
    i = i+1;
    prompt{i}='Product Gas Concentration :';
    defaults{i}='ProductGasConcentration';
end
handle.SaveNames = {};
if i == 0
    warndlg('First you should select the data you want to be saved','Select Data!!!');
else
    handle.SaveNames=inputdlg(prompt,title,1,defaults);
    if (~isempty(handle.SaveNames))
        %     handle.SaveNames{end+1} = '1';
    else
        %     set(handle.StraitTubelar,'value',0);
    end
    handle.SaveNames
end