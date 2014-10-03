function [subStructList,idx] = where(StructList,fieldName,value)
% WHERE filter a list of structure such that StructList.(...).fieldName == value

filedNameList = fieldnames(StructList);

found = 0;
if isfield(StructList(1),fieldName)
    %___________________________________________________________
    % try first level
    idx = find(cellfun(@(x) isequal(x,value), {StructList.(fieldName)}));
    found = 1;
else
    %___________________________________________________________
    % try nested structures
    for iField = 1:numel(filedNameList)
        if isstruct(StructList(1).(filedNameList{iField}))
            [~,idx] = where([StructList.(filedNameList{iField})],fieldName,value);
            found = found + 1;
        end
    end
end

switch found
    case 0
        warning('No field ''%s''  found in the structure',fieldName);
        idx = 1:numel(StructList);
    case 1
    otherwise
        error('Multiple fields named ''%s'' found',fieldName);
end

subStructList = StructList(idx);





end





