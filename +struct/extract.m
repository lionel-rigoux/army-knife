function valueList = extract(structList,fieldName)


filedNameList = fieldnames(structList);

if isfield(structList(1),fieldName)
    %___________________________________________________________
    % try first level
    valueList = elvis( isnumeric(structList(1).(fieldName)), ...
        [structList.(fieldName)]    ,...
        {structList.(fieldName)} );
    return
    
else
    %___________________________________________________________
    % try nested structures
    for iField = 1:numel(filedNameList)
        if isstruct(structList(1).(filedNameList{iField})) 
            valueList = struct.exctract([structList.(filedNameList{iField})],fieldName);
            if ~isempty(valueList)
                return ;
            end
            
            
        end
    end
end

valueList = [];




end





