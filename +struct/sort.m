function sortedStructList = sort(structList,fieldList)

% catch shortcuts
if isstr(fieldList)
    fieldList = {fieldList};
end

% extract sorting values
for i=1:numel(fieldList)
    values(:,i) = struct.extract(structList,fieldList{i},true); 
end

[~,index] = sortrows(values);

sortedStructList = structList(index) ;
    
