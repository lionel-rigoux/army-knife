function structListStacked = lapply(structList, fHandle, fieldList)
% lapply(structList, fHandle, fieldList)
% batch apply the function handled by fHandle on all fields of the
% structlist collapsed according to levels in fields of fieldList.

% extract condition idx
if ~exist('fieldList') || isempty(fieldList)
    familyStruct.families = {1:numel(structList)} ;
else
    familyStruct = struct.getFamilies(structList,fieldList);  
end


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
                
                assert(~isempty(fieldValues));
                
                value = fHandle(fieldValues);
                
                s = size(value);
                if sum(s>1)>1 && s(1) == 1
                try
                    value = squeeze(value);
                end
                end
            catch
                switch numel(unique(fieldValues))
                    case 0
                        value = [];
                    case 1
                        value = fieldValues(1);
                    otherwise
                        value = NaN;
                end
            end
        end
        structListStacked.(fieldName) = value;
    end
end