function [subStructList,idx] = where(StructList,fieldName,value)
% WHERE filter a list of structure such that StructList.(...).fieldName == value

filedNameList = fieldnames(StructList);
found = false;

if isfield(StructList(1),fieldName)
    %___________________________________________________________
    % try first level
    idx = find(cellfun(@(x) isequal(x,value), {StructList.(fieldName)}));
    found = true;
else
    %___________________________________________________________
    % try nested structures
    for iField = 1:numel(filedNameList)
        if isstruct(StructList(1).(filedNameList{iField}))
            [~,idxTemp] = where([StructList.(filedNameList{iField})],fieldName,value);
            if numel(idxTemp)<numel(StructList)
                if found && ~isempty(setdiff(idxTemp,idx))
                        	error('Multiple incongruent fields named ''%s'' found',fieldName);
                end
                found = true;
                idx = idxTemp;
            end
        end
    end
end

if ~found
    idx = 1:numel(StructList);
end
subStructList = StructList(idx);





end





