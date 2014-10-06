function familyStruct = getFamilies(structList,fieldNameList,prefix,idx)

    if ~exist('prefix'), prefix = ''                 ; end
    if ~exist('idx')   , idx    = 1:numel(structList); end

    if iscell(fieldNameList) && numel(fieldNameList) == 1
        fieldNameList = fieldNameList{1};
    end
%______________________________________________________________________
% simple family
if isstr(fieldNameList) % not a list

    
    fieldName = fieldNameList;
    
    % find list of levels
    valueList = struct.extract(structList,fieldName) ;
    familiesName = unique(valueList,'sorted');
    
    % iterate over levels to find indices
    families = {};
    for iF = 1:numel(familiesName)
        
        if iscell(valueList)
            familyValue = familiesName{iF};
            isInFamily = cellfun(@(v) isequal(v,familyValue), valueList);
        else
            familyValue = familiesName(iF);
            isInFamily = (valueList == familyValue);
        end
        families{iF} = idx(isInFamily);
    end
    
    % storage
    familyStruct.families = families;
    
    % ensure string storage of family level
    
    if isnumeric(familiesName)
        familiesNameLabel = cellfun(@(x) {num2str(x)}, num2cell(familiesName)) ;
    else
        familiesNameLabel = familiesName ;
    end
    familyStruct.familiesName = cellfun(@(x) {[prefix fieldName ':' x]}, familiesNameLabel) ; 
        
 
%______________________________________________________________________
% conjunction family
else
    familyStruct = struct('families',{{}},'familiesName',{{}});
    
    familyStruct_n = struct.getFamilies(structList,fieldNameList{1});
    
    for iF=1:numel(familyStruct_n.families)
        prefix = [familyStruct_n.familiesName{iF} ' & '];
        idx = familyStruct_n.families{iF};
        familyStruct_np1 = struct.getFamilies(structList(idx),fieldNameList(2:end),prefix,idx); 
        
        familyStruct.families = {familyStruct.families{:} familyStruct_np1.families{:}};
        familyStruct.familiesName = {familyStruct.familiesName{:} familyStruct_np1.familiesName{:}};
        
    end
    
end




end


function familyStruct = getFamilies_prefixed(structList,fieldNameList)

    
end
