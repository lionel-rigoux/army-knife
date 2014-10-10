function structListStacked = lapply(structList, fHandle, fieldList)
% lapply(structList, fHandle, fieldList)
% batch apply the function handled by fHandle on all fields of the
% structlist collapsed according to levels in fields of fieldList.

% extract condition idx

familyStruct = struct.getFamilies(structList,fieldList);

for iF = 1:numel(familyStruct.families)
    idx = familyStruct.families{iF} ;
    
    structListStacked(iF) = safe_structfun(fHandle,structList(idx)) ;
end
end

function structListStacked = safe_structfun(fHandle,structList)
    fieldList = fieldnames(structList(1));
    for i=1:numel(fieldList)
        fieldName = fieldList{i};
        
        if isstruct(structList(1).(fieldName)) % recursive call
            value = safe_structfun(fHandle,[structList.(fieldName)]);
        else
            
            fieldValues = struct.extract(structList,fieldName);
            try
                value = fHandle(fieldValues);
            catch
                if numel(unique(fieldValues)) == 1
                    value = fieldValues(1);
                else
                    value = NaN;
                end
            end
        end
        structListStacked.(fieldName) = value;
    end
end