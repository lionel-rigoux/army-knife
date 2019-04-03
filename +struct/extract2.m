function valueList = extract2(structList,fieldName,forceArray, listPreviousField)

if ~exist('forceArray','var')
    forceArray = false;
end

if ~exist('listPreviousField','var')
    listPreviousField = {};
end

fieldNameList = fieldnames(structList);

decField = decomposeName(fieldName);
nDec = length(decField);

targetField = decField{end};


isMatch =1;
try
    for iDec = 1:(nDec-1)
        isMatch = isMatch & strcmp(decField{iDec}, listPreviousField{end + iDec + 1 - nDec});
    end
catch
    isMatch=0;
end


if isfield(structList(1),targetField) & isMatch ==1
    
    %___________________________________________________________
    % try first level
    valueList = {structList.(targetField)} ;
    
    % try to convert into matrix
    if ~forceArray && isnumeric(valueList{1})
        sz = size(valueList{1}) ;
        if sum(sz>1) > 1
            valueList = cellfun( @(x) reshape(x, [1 sz]), valueList, 'UniformOutput',false) ;
        end
        valueList = cat(1,valueList{:}) ;
    end
    
    return
    
else
    %___________________________________________________________
    % try nested structures
    for iField = 1:numel(fieldNameList)
        if isstruct(structList(1).(fieldNameList{iField}))
            updatedPreviousField = [listPreviousField fieldNameList{iField}];
            
%             isMatch =1;
%             try
%                 for iDec = 1:(nDec-1)
%                     isMatch = isMatch & strcmp(decField{iDec}, listPreviousField{end + iDec + 1 - nDec});
%                 end
%             catch
%                 isMatch=0;
%             end
% 
%                disp(listPreviousField)

            
            
            valueList = struct.extract2([structList.(fieldNameList{iField})],fieldName,forceArray, updatedPreviousField );
            if ~isempty(valueList)
                return ;
            end
            
            
        end
    end
end

valueList = [];




end





