function handle = NyPMSelectionChange(~,~,handle)
title='Set Parameters';
prompt{1}='Nx :';
prompt{2}='Ny :';
switch get(get(handle.PMButtonGroup,'selectedobject'),'tag')
    case 'Strait'
        handle.BuildInput = {};
        prompt{3}='Height :';
        prompt{4}='dy :';
        prompt{5}='dy0 :';
        default_ans={'100','100','10','10','5'};
        handle.BuildInput=inputdlg(prompt,title,1,default_ans);
        if (~isempty(handle.BuildInput))
            handle.BuildInput{end+1} = '1';
        else
            set(handle.StraitTubelar,'value',0);
        end
    case 'Sine'
        handle.BuildInput = {};
        prompt{3}='Height :';
        prompt{4}='dy :';
        prompt{5}='dy0 :';
        prompt{6}='A :';
        prompt{7}='w :';
        default_ans={'100','100','5','2','5','2','0.2'};
        handle.BuildInput=inputdlg(prompt,title,1,default_ans);
        if (~isempty(handle.BuildInput))
            handle.BuildInput{end+1} = '2';
        else
            set(handle.SineTubelar,'value',0);
        end
    case 'Cubic'
        handle.BuildInput = {};
        prompt{3}='Height :';
        prompt{4}='Width :';
        prompt{5}='dx :';
        prompt{6}='dy :';
        prompt{7}='dx0 :';
        prompt{8}='dy0 :';
        default_ans={'100','100','10','4','5','10','2','5'};
        handle.BuildInput=inputdlg(prompt,title,1,default_ans);
        if (~isempty(handle.BuildInput))
            handle.BuildInput{end+1} = '3';
        else
            set(handle.Cubic,'value',0);
        end
    case 'Circular'
        handle.BuildInput = {};
        prompt{3}='Radius :';
        prompt{4}='dx :';
        prompt{5}='dy :';
        prompt{6}='dx0 :';
        prompt{7}='dy0 :';
        default_ans={'100','100','5','5','10','2','5'};
        handle.BuildInput=inputdlg(prompt,title,1,default_ans);
        if (~isempty(handle.BuildInput))
            handle.BuildInput{end+1} = '4';
        else
            set(handle.Circular,'value',0);
        end
    case 'RandCubic'
        handle.BuildInput = {};
        prompt{3}='Min Height :';
        prompt{4}='Max Height :';
        prompt{5}='Min Width :';
        prompt{6}='Max Width :';
        prompt{7}='Porosity :';
        default_ans={'100','100','4','10','4','10','0.7'};
        handle.BuildInput=inputdlg(prompt,title,1,default_ans);
        if (~isempty(handle.BuildInput))
            handle.BuildInput{end+1} = '5';
        else
            set(handle.RandCubic,'value',0);
        end
    case 'RandCircular'
        handle.BuildInput = {};
        prompt{3}='Min Radius :';
        prompt{4}='Max Radius :';
        prompt{5}='Porosity :';
        default_ans={'100','100','3','7','0.7'};
        handle.BuildInput=inputdlg(prompt,title,1,default_ans);
        if (~isempty(handle.BuildInput))
            handle.BuildInput{end+1} = '6';
        else
            set(handle.RandCircular,'value',0);
        end
end
if ~(any(isnan(str2double(handle.BuildInput))) || isempty(handle.BuildInput))
    handle = BuildButtonCallback2(handle);
%     set(handle.BuildButton,'enable','on');
% else
%     set(handle.BuildButton,'enable','off');
end
end