function familyStruct = getFamilies(structList,fieldName)

    valueList = struct.extract(structList,fieldName);
    
    
    familiesNames = sort(unique(valueList));
    
    families = {};
    for iF = 1:numel(familiesNames)
        
        if iscell(valueList)
            familyValue = familiesNames{iF};
            isInFamily = cellfun(@(v) isequal(v,familyValue), valueList);
        else
            familyValue = familiesNames(iF);
            isInFamily = (valueList == familyValue);
        end
        families{iF} = find(isInFamily);
    end
    
    if isnumeric(familiesNames)
        familiesNames = cellfun(@(x) {num2str(x)},num2cell(familiesNames));
    end
    familyStruct.familiesName = familiesNames ;
    familyStruct.families = families;
        