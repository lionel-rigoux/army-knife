function structListStacked = apply(structList, fHandle, fieldList)
% STRUCT.APPLY
% apply(structList, fHandle, fieldList)
% batch apply the function handled by fHandle to all fields of structList
% grouped according to the categories defined by structList (list of field
% names)

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