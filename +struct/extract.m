function valueList = extract(structList,fieldName,forceArray)

if ~exist('forceArray','var')
    forceArray = false;
end

filedNameList = fieldnames(structList);

if isfield(structList(1),fieldName)
    %___________________________________________________________
    % try first level
    valueList = {structList.(fieldName)} ;
    
    % try to convert into matrix
    if ~forceArray && isnumeric(valueList{1})
        valueList = cell2mat(valueList);
    end
    
    return
    
else
    %___________________________________________________________
    % try nested structures
    for iField = 1:numel(filedNameList)
        if isstruct(structList(1).(filedNameList{iField})) 
            valueList = struct.extract([structList.(filedNameList{iField})],fieldName);
            if ~isempty(valueList)
                return ;
            end
            
            
        end
    end
end

valueList = [];




end





